import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/helper/input_validator.dart';

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
    const DropDownValueModel(name: 'Available', value: "available"),

  ];
  late SingleValueDropDownController statusController =
  SingleValueDropDownController();
  validateFields() {
    return true;
  }

  isFormValid() {
    if (InputValidators.simpleValidation(statusController.dropDownValue?.value??"") == null &&
        InputValidators.nameValidation(dispatchedToController.text) == null &&
        InputValidators.mobileNumberValidator(userContactController.text) == null &&
        InputValidators.simpleValidation(startDateController.text) == null &&
        InputValidators.simpleValidation(endDateController.text) == null &&
        InputValidators.simpleValidation(siteInfoController.text) == null) {
      return true;
    }
    return false;
  }

  void updateMachine() {
    databaseReference.child("machine/${storage.read("machineKey")}").update({
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "renterName": dispatchedToController.text,
      "renterContact": userContactController.text,
      "rentSite": siteInfoController.text,
      "dispatcherName": storage.read("name"),

      "status" : statusController.dropDownValue?.value.toString()
    }).then((value) => {print("Machine Updated-dispatched")});
  }
}
