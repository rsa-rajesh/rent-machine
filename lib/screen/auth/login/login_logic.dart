import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_routes.dart';
import '../../../core/helper/input_validator.dart';
import '../../../models/users_list_model.dart';

class LoginLogic extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  List<UserData> userData = [];
  final storage = GetStorage();

  validateFields() {
    if (InputValidators.simpleValidation(phoneController.text) == null &&
        InputValidators.simpleValidation(passwordController.text) == null) {
      return true;
    }
    return false;
  }

  void login() async {
    await databaseReference
        .child("users")
        .orderByChild("contact")
        .equalTo(phoneController.text)
        .get()
        .then((value) {
      for (DataSnapshot snapshot in value.children) {
        UserData userDataa =
            UserData.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
        userData.add(userDataa);
      }
    });

    if (userData.isEmpty) {
      print("user not found");
    } else {
      bool isPasswordValid = false;
      for (var a in userData) {
        if (a.password == passwordController.text.toString()) {
          isPasswordValid = true;
          storage.write("name", a.fullName);
          storage.write("role", a.position);
        }
      }
      if(isPasswordValid){
        Get.toNamed(AppRoutes.welcomeScreen);
      }else{
        print("user or password do not match");
      }

    }
  }
}
