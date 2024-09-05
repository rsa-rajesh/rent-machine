import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_routes.dart';

import '../../core/helper/input_validator.dart';
import '../../core/widgets/loading_dialog.dart';
import '../view_machine/view_machine_logic.dart';

class DispatchMachineLogic extends GetxController {
  TextEditingController dispatchedToController = TextEditingController();
  TextEditingController userContactController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController siteInfoController = TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final storage = GetStorage();

  List<DropDownValueModel> status = [
    const DropDownValueModel(name: 'Rent', value: "rent"),
    const DropDownValueModel(name: 'On-Site', value: "onsite"),
    // const DropDownValueModel(name: 'Available', value: "available"),
  ];
  late SingleValueDropDownController statusController =
      SingleValueDropDownController();

  validateFields() {
    return true;
  }

  isFormValid() {
    if (InputValidators.simpleValidation(
                statusController.dropDownValue?.value ?? "") ==
            null &&
        InputValidators.nameValidation(dispatchedToController.text) == null &&
        InputValidators.mobileNumberValidator(userContactController.text) ==
            null &&
        InputValidators.simpleValidation(startDateController.text) == null &&
        InputValidators.simpleValidation(endDateController.text) == null &&
        InputValidators.simpleValidation(siteInfoController.text) == null) {
      return true;
    }
    return false;
  }

  void updateMachine() {
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
        .update({
          "startDate": startDateController.text,
          "endDate": endDateController.text,
          "renterName": dispatchedToController.text,
          "renterContact": userContactController.text,
          "rentSite": siteInfoController.text,
          "dispatcherName": storage.read("name"),
          "status": statusController.dropDownValue?.value.toString()
        })
        .then((value) => {isError1 = false})
        .catchError((onError) => {isError1 = true});

    databaseReference
        .child("machine_logs")
        .push()
        .set({
          "machine": storage.read("machineKey"),
          "startDate": startDateController.text,
          "endDate": endDateController.text,
          "date": DateTime.now().toString(),
          "renterName": dispatchedToController.text,
          "renterContact": userContactController.text,
          "rentSite": siteInfoController.text,
          "action": "dispatched",
          "dispatcherName": storage.read("name"),
          "status": statusController.dropDownValue?.value.toString(),
          "remarks": "dispatched"
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

      final ViewMachineLogic c = Get.find();
      c.getData();
      Get.back();
      Get.back();

    }
  }
}
