import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/widgets/costume_dialog_with_cross.dart';
import '../../../models/users_list_model.dart';
import '../../../routes/app_routes.dart';

class ListUserLogic extends GetxController {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  List<Users> user= [];
  final storage = GetStorage();

  @override
  void onInit() async {
    getUsers();
    super.onInit();
  }

  void showDialogs(Users userData) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return CostumeDialogWithCross(
          title: 'User Options',
          button2Enabled: true,
          buttom1Lavel: "Update",
          onButton1Clicked: () {
            storage.write("is_update_user", true);
            storage.write("update_user_id", userData.key);
            storage.write("update_user", userData.userData?.toJson());
            Get.toNamed(AppRoutes.addUserScreen);
          },
          onButton2Clicked: () {
            deleteUsers(userData.key ?? "");
          },
          buttom2Lavel: "Delete",
          message: 'Do you like to delete or update this user',
          titleColor: Colors.red,
        );
      },
    );
  }

  void getUsers() async {
    await databaseReference.child("users").get().then((value) {
      user.clear();
      for (DataSnapshot snapshot in value.children) {
        UserData userDatas =
            UserData.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
        user.add(Users(key: snapshot.key, userData: userDatas));
      }
    });
    update();
  }

  void deleteUsers(String key) async {
    await databaseReference.child("users/$key").remove().then((value) {
      getUsers();
    });
  }

  void addUser() {
    storage.write("is_update_user", false);
    storage.write("update_user_id", "");
    storage.write("update_user", "");
    Get.toNamed(AppRoutes.addUserScreen);
  }
}
