import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/core/widgets/costume_remarks_dialog.dart';
import 'package:rent_mechine/routes/app_routes.dart';
import '../../core/widgets/costume_dialog.dart';
import '../../core/widgets/costume_dialog_with_cross.dart';
import '../../core/widgets/loading_dialog.dart';
import '../../models/machine_list_model.dart';

class ViewMachineLogic extends GetxController {
  List<bool> isSelected = [
    true,
    false,
    false,
  ];
  final storage = GetStorage();

  List<Machine> machines = [];
  List<Machine> machinesOriginal = [];
  Machine? selectedMachine;

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void onInit() async {
    await databaseReference.child("machine").get().then((value) {
      machinesOriginal.clear();
      for (DataSnapshot snapshot in value.children) {
        MachineData machineData = MachineData.fromJson(
            Map<String, dynamic>.from(snapshot.value as Map));
        machinesOriginal
            .add(Machine(key: snapshot.key, machineData: machineData));
      }
    });
    print(machinesOriginal[0].machineData?.machineType);
    updateSelected();
    super.onInit();
  }

  getStatusFillColor(String orderStatus) {
    if (orderStatus.toLowerCase() == "onsite") {
      return Colors.green[50];
    } else if (orderStatus.toLowerCase() == "rent") {
      return Colors.red[50];
    }
    return Colors.blue[50];
  }

  getStatusColor(String orderStatus) {
    if (orderStatus.toLowerCase() == "onsite") {
      return Colors.green[900];
    } else if (orderStatus.toLowerCase() == "rent") {
      return Colors.red[900];
    }
    return Colors.blue[900];
  }

  getSelectedFillColor() {
    if (isSelected[0]) {
      return Colors.blue[50];
    }
    if (isSelected[1]) {
      return Colors.green[50];
    }
    if (isSelected[2]) {
      return Colors.red[50];
    }
  }

  getSelectedColor() {
    if (isSelected[0]) {
      return Colors.blue[900];
    }
    if (isSelected[1]) {
      return Colors.green[900];
    }
    if (isSelected[2]) {
      return Colors.red[900];
    }
  }

  void updateSelected() {
    machines.clear();
    if (isSelected[0]) {
      for (var a in machinesOriginal) {
        if (a.machineData?.status == "available") {
          machines.add(a);
        }
      }
      update();

      return;
    }
    if (isSelected[1]) {
      for (var a in machinesOriginal) {
        if (a.machineData?.status == "onsite") {
          machines.add(a);
        }
      }
      update();
      return;
    }
    if (isSelected[2]) {
      for (var a in machinesOriginal) {
        if (a.machineData?.status == "rent") {
          machines.add(a);
        }
      }
      update();

      return;
    }
  }

  void rentMachine(String? key) {
    storage.write("machineKey", key);
    Get.toNamed(AppRoutes.machineDispatchScreen);
  }

  void showOptionsDialog() {
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
            storage.write("is_update_machine", true);
            storage.write("update_machine_id", selectedMachine?.key);
            storage.write(
                "update_machine", selectedMachine?.machineData?.toJson());
            Get.toNamed(AppRoutes.addMachineScreen);
          },
          onButton2Clicked: () {
            deleteMachine(selectedMachine?.key ?? "");
          },
          buttom2Lavel: "Delete",
          message: 'Do you like to delete or update this user',
          titleColor: Colors.red,
        );
      },
    );
  }

  void deleteMachine(String key) async {
    await databaseReference.child("machine/$key").remove().then((value) async {
      await databaseReference.child("machine").get().then((value) {
        machinesOriginal.clear();
        for (DataSnapshot snapshot in value.children) {
          MachineData machineData = MachineData.fromJson(
              Map<String, dynamic>.from(snapshot.value as Map));
          machinesOriginal
              .add(Machine(key: snapshot.key, machineData: machineData));
        }
      });
      updateSelected();
    });
  }

  void updateRentStatus(String s) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        context = context;
        return CostumeDialog(
          title: 'Update Machine Status',
          button2Enabled: true,
          buttom1Lavel: "Yes",
          onButton1Clicked: () {
            showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (BuildContext context) {
                context = context;
                return CostumeRemarksDialog(
                  onButton1Clicked: (remarks) {
                    updateMachine(s, remarks);
                  },
                );
              },
            );

            // updateMachine(s);
          },
          onButton2Clicked: () {},
          buttom2Lavel: "No",
          message:
              'Are you sure you want to $s the Rent/InSight of this machine',
          titleColor: s == "Complete" ? Colors.green : Colors.red,
        );
      },
    );
  }

  Future<void> updateMachine(String status, remarks) async {
    bool isError1 = false;
    bool isError2 = false;

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

    databaseReference
        .child("machine/${storage.read("machineKey")}")
        .update({"dispatcherName": storage.read("name"), "status": "available"})
        .then((value) => {isError1 = false})
        .catchError((onError) => {isError1 = true});

    databaseReference
        .child("machine_logs")
        .push()
        .set({
          "machine": storage.read("machineKey"),
          "startDate": selectedMachine?.machineData?.startDate,
          "endDate": selectedMachine?.machineData?.endDate,
          "date": DateTime.now().toString(),
          "renterName": selectedMachine?.machineData?.renterName,
          "renterContact": selectedMachine?.machineData?.renterContact,
          "rentSite": selectedMachine?.machineData?.rentSite,
          "action": status,
          "dispatcherName": storage.read("name"),
          "status": "available",
          "remarks": remarks
        })
        .then((value) => {isError2 = false})
        .catchError((onError) => {isError2 = true});
    navigator?.pop();

    if (isError1 && isError2) {
      Fluttertoast.showToast(
          msg: "Error Updating Machine",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      await databaseReference.child("machine").get().then((value) {
        machinesOriginal.clear();
        for (DataSnapshot snapshot in value.children) {
          MachineData machineData = MachineData.fromJson(
              Map<String, dynamic>.from(snapshot.value as Map));
          machinesOriginal
              .add(Machine(key: snapshot.key, machineData: machineData));
        }
      });
      print(machinesOriginal[0].machineData?.machineType);
      updateSelected();
      Get.back();
    }
  }
}
