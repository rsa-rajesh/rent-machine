import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddMachineLogic extends GetxController {

  TextEditingController serialNoController = TextEditingController();
  TextEditingController typeOfMachineController = TextEditingController();
  File? imageFile;

  validateFields() {
    return true;
  }

}
