import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_mechine/models/machine_list_model.dart';
import 'package:rent_mechine/screen/view_machine/view_machine_logic.dart';
import '../../core/helper/input_validator.dart';
import '../../core/widgets/loading_dialog.dart';

class AddMachineLogic extends GetxController {

  TextEditingController serialNoController = TextEditingController();
  TextEditingController typeOfMachineController = TextEditingController();
  File? pickedFile;
  String imageUrl = "";
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  FirebaseStorage fbStorage = FirebaseStorage.instance;
  MachineData? updateMachine;
  String? updateKey;
  final storage = GetStorage();
  bool isUpdate = false;

  validateFields() {
    if (InputValidators.simpleValidation(serialNoController.text) == null &&
        InputValidators.simpleValidation(typeOfMachineController.text) == null &&
        pickedFile != null) {
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    if (storage.read("is_update_machine")) {
      updateMachine = MachineData.fromJson(storage.read("update_machine"));
      updateKey = storage.read("update_machine_id");
      if (updateMachine != null) {
        serialNoController.text = updateMachine!.serialNo ?? "";
        typeOfMachineController.text = updateMachine!.machineType ?? "";
        imageUrl = updateMachine!.machinePhoto ?? "";
        isUpdate = true;
      }
    }
    super.onInit();
  }

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
    return croppedImage;
  }

  void addMachine() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return const Loading(
         'Adding Machine...',
          false,
        );
      },
    );

    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique file name
    Reference storageRef = fbStorage.ref().child('uploads/$fileName');

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
      "status": "available"
    }).then((value) => {print("Machine Created")});
    navigator?.pop();

    Fluttertoast.showToast(
        msg: "New Machine Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[900],
        textColor: Colors.white,
        fontSize: 16.0);
    Get.back();
  }

  updateMachineDate() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return const Loading(
          "Updating Machine..",
          false,
        );
      },
    );
    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique file name
    Reference storageRef = fbStorage.ref().child('uploads/$fileName');

    // Upload the file
    UploadTask uploadTask = storageRef.putFile(pickedFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    // Get the download URL
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);

    databaseReference.child("machine/$updateKey").update({
      "serialNo": serialNoController.text,
      "machineType": typeOfMachineController.text,
      "machinePhoto": downloadUrl,
    }).then((value) => {print("Machine Updated")});

    final ViewMachineLogic c = Get.find();
    c.getData();
    navigator?.pop();
    Get.back();
  }
}
