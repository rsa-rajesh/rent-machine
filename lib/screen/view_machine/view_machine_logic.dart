import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_routes.dart';

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
      // return Colors.blue[50];
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
}
