import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/input_validator.dart';

class AddUserLogic extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  validateFields() {
    if (InputValidators.simpleValidation(userNameController.text) == null &&
        InputValidators.nameValidation(fullNameController.text) == null &&
        InputValidators.simpleValidation(contactController.text) == null &&
        InputValidators.simpleValidation(positionController.text) == null &&
        InputValidators.passwordValidator(passwordController.text) == null &&
        InputValidators.confirmPasswordValidator(confirmPasswordController.text,passwordController.text) ==
            null) {
      return true;
    }
    return false;
  }

}
