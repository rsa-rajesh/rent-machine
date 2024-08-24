import 'dart:ffi';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  validateFields() {
    if (InputValidators.nameValidation(fullNameController.text) == null &&
        InputValidators.mobileNumberValidator(contactController.text) == null &&
        InputValidators.simpleValidation(
                positionController.dropDownValue?.value ?? "") ==
            null &&
        InputValidators.confirmPasswordValidator(
                confirmPasswordController.text, passwordController.text) ==
            null) {
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
      databaseReference.child("users").push().set({
        "fullName": fullNameController.text,
        "contact": contactController.text,
        "position": positionController.dropDownValue?.value ?? "user",
        "password": passwordController.text,
      }).then((value) => {print("User Created")});
    } else {
      print("user already created for this contact");
    }
  }

  updateUserDb() {
    databaseReference.child("users/$updateKey").update({
      "fullName": fullNameController.text,
      "contact": contactController.text,
      "position": positionController.dropDownValue?.value ?? "user",
      "password": passwordController.text
    }).then((value) => {print("User updated")});
  }
}
