import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/enums/validation_type.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_fields.dart';
import 'add_user_logic.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    // final logic = Get.find<AddUserLogic>();

    return GetBuilder<AddUserLogic>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Add User"),
            centerTitle: true,
          ),
          backgroundColor: Colors.grey.shade100,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CostumeFormField(
                  validationType: ValidationType.common,
                  controller: logic.userNameController,
                  hintText: "Select your Username",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Select User Name",
                ),
                Gap(12),
                CostumeFormField(
                  validationType: ValidationType.name,
                  controller: logic.fullNameController,
                  hintText: "Full Name",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Full Name",
                ),
                Gap(12),
                CostumeFormField(
                  validationType: ValidationType.common,
                  controller: logic.contactController,
                  hintText: "Contact Information",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Contact Information",
                ),
                Gap(12),
                CostumeFormField(
                  validationType: ValidationType.common,
                  controller: logic.positionController,
                  hintText: "Position",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Position",
                ),
                Gap(12),
                CostumeFormField(
                  validationType: ValidationType.password,
                  controller: logic.passwordController,
                  hintText: "Select your Password",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Select your Password",
                ),
                Gap(12),
                CostumeFormField.confirmPassword(
                  validationType: ValidationType.confirmPassword,
                  controller: logic.confirmPasswordController,
                  hintText: "Confirm Password",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Confirm Password",
                  passwordController: logic.passwordController,
                ),
                Gap(62),
                CostumeButtons.common(
                  labelText: 'Add User',
                  onPressed: () {
                    // logic.createUser();
                  },
                  isEnabled: logic.validateFields(),
                ),
              ],
            ),
          ));
    });
  }
}
