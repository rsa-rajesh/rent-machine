import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_mechine/models/users_list_model.dart';
import '../../../core/helper/input_validator.dart';

class AddUserLogic extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late SingleValueDropDownController positionController =
  SingleValueDropDownController();
  List<DropDownValueModel> userType = [
    const DropDownValueModel(name: 'Admin', value: "admin"),
    const DropDownValueModel(name: 'User', value: "user"),
  ];

  List<UserData> userData = [];
  UserData? updateUser;
  String? updateKey;
  final storage = GetStorage();
  bool isUpdate = false;

  File? pickedFile;
  String imageUrl = "";
  FirebaseStorage fbStorage = FirebaseStorage.instance;


  validateFields() {
    if (InputValidators.nameValidation(fullNameController.text) == null &&
        InputValidators.mobileNumberValidator(contactController.text) == null &&
        InputValidators.simpleValidation(
            positionController.dropDownValue?.value ?? "") ==
            null &&
        InputValidators.confirmPasswordValidator(
            confirmPasswordController.text, passwordController.text) ==
            null && pickedFile!=null) {
      return true;
    }
    return false;
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    if (storage.read("is_update_user")) {
      updateUser = UserData.fromJson(storage.read("update_user"));
      updateKey = storage.read("update_user_id");
      if (updateUser != null) {
        fullNameController.text = updateUser!.fullName ?? "";
        contactController.text = updateUser!.contact ?? "";
        passwordController.text = updateUser!.password ?? "";
        imageUrl = updateUser!.userPhoto??"";
        confirmPasswordController.text = updateUser!.password ?? "";
        isUpdate = true;
      }
    }
    super.onInit();
  }

  void createUser() async {
    await databaseReference
        .child("users")
        .orderByChild("contact")
        .equalTo(contactController.text)
        .get()
        .then((value) {
      for (DataSnapshot snapshot in value.children) {
        UserData userDataa =
        UserData.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
        userData.add(userDataa);
      }
    });

    if (userData.isEmpty) {
      String fileName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate a unique file name
      Reference storageRef = fbStorage.ref().child('uploads/$fileName');
      // Upload the file
      UploadTask uploadTask = storageRef.putFile(pickedFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      // Get the download URL
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      if (kDebugMode) {
        print(downloadUrl);
      }



      databaseReference.child("users").push().set({
        "fullName": fullNameController.text,
        "contact": contactController.text,
        "position": positionController.dropDownValue?.value ?? "user",
        "password": passwordController.text,
        "userPhoto": downloadUrl

      }).then((value) => {
      Fluttertoast.showToast(
      msg: "User Created",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0)
    });
      Get.back();
      Get.back();

    } else {
      Fluttertoast.showToast(
      msg: "User already created for this contact",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
    }
  }

  updateUserDb() async {

    String fileName = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generate a unique file name
    Reference storageRef = fbStorage.ref().child('uploads/$fileName');

    // Upload the file
    UploadTask uploadTask = storageRef.putFile(pickedFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    // Get the download URL
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print(downloadUrl);
    }

    databaseReference.child("users/$updateKey").update({
      "fullName": fullNameController.text,
      "contact": contactController.text,
      "position": positionController.dropDownValue?.value ?? "user",
      "password": passwordController.text,
      "userPhoto": downloadUrl

    }).then((value) =>
    {
    Fluttertoast.showToast(
    msg: "User updated",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0)
      // if (kDebugMode) {print("User updated")}
    });
    Get.back();
    Get.back();

  }


  pickImage(ImageSource imageSource) async {
    File? file = await pickSingleImage(imageSource);
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
}
