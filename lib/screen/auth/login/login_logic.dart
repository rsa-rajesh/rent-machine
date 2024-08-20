import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/input_validator.dart';

class LoginLogic extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  validateFields() {
    if (InputValidators.simpleValidation(userNameController.text) == null &&
        InputValidators.simpleValidation(passwordController.text) == null) {
      return true;
    }
    return false;
  }

  void login() async {

  }

}
