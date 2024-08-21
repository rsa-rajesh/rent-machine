import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/helper/input_validator.dart';

class AddMachineLogic extends GetxController {
  TextEditingController serialNoController = TextEditingController();
  TextEditingController typeOfMachineController = TextEditingController();
  File? pickedFile;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  FirebaseStorage storage = FirebaseStorage.instance;

  // final ImagePicker _picker = ImagePicker();

  validateFields() {
    if (InputValidators.simpleValidation(serialNoController.text) == null &&
        InputValidators.simpleValidation(typeOfMachineController.text) ==
            null &&
        pickedFile != null) {
      return true;
    }
    return false;
  }

  // void pickImage() {
  //
  // }

  pickImage() async {
    File? file = await pickSingleImage(ImageSource.camera);
    if (file != null) {
      pickedFile = file;
      update();
    }
  }

  Future<File?> pickSingleImage(ImageSource source) async {
    try {
      final picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        final file = File(image.path);
        final croppedFile = await cropCustomImage(file);
        if (croppedFile != null) {
          final resultFile = File(croppedFile.path);
          return resultFile;
        }
        return file;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CroppedFile?> cropCustomImage(File imageFile) async {
    final croppedImage = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.jpg,
      maxHeight: 720,
      maxWidth: 720,
      aspectRatio: const CropAspectRatio(ratioX: 8, ratioY: 8),
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
      ],
      compressQuality: 50,
    );
    // debugPrint()
    return croppedImage;
  }

  void addMachine() async {
    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique file name
    Reference storageRef = storage.ref().child('uploads/$fileName');

    // Upload the file
    UploadTask uploadTask = storageRef.putFile(pickedFile!);
    TaskSnapshot taskSnapshot = await uploadTask;

    // Get the download URL
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);

    databaseReference.child("machine").push().set({
      "serialNo": serialNoController.text,
      "machineType": typeOfMachineController.text,
      "machinePhoto": downloadUrl,
      "status" : "available"
    }).then((value) => {print("User Created")});
  }
}
