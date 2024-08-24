import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_routes.dart';
import '../../../core/helper/input_validator.dart';
import '../../../core/widgets/loading_dialog.dart';
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

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return const Loading(
          'loading...',
          false,
        );
      },
    );

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
      navigator?.pop();
      Fluttertoast.showToast(
          msg: "User not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      bool isPasswordValid = false;
      for (var a in userData) {
        if (a.password == passwordController.text.toString()) {
          isPasswordValid = true;
          storage.write("name", a.fullName);
          storage.write("role", a.position);
          storage.write("login", true);
        }
      }
      if(isPasswordValid){
        navigator?.pop();
        Get.offAndToNamed(AppRoutes.welcomeScreen);
      }else{
        navigator?.pop();
        print("user or password do not match");
        Fluttertoast.showToast(
            msg: "user or password do not match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }
  }
}
