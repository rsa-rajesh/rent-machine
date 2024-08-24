import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/app_managers/color_manager.dart';
import '../../../core/enums/validation_type.dart';
import '../../../core/helper/input_validator.dart';
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
            title: logic.isUpdate?const Text("Update User"):const Text("Add User"),
            centerTitle: true,
          ),
          backgroundColor: Colors.grey.shade100,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
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
                  validationType: ValidationType.phone,
                  controller: logic.contactController,
                  hintText: "Contact",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Contact",
                ),
                Gap(12),
                // CostumeFormField(
                //   validationType: ValidationType.common,
                //   controller: logic.positionController,
                //   hintText: "Position",
                //   onChanged: () {
                //     setState(() {});
                //   },
                //   labelText: "Position",
                // ),

                _buildDropDownFormField(
                    hintText: "Position",
                    inputType: TextInputType.text,
                    mainController: logic,
                    onChanged: () {
                      setState(() {});
                    },
                    controller: logic.positionController),
                Gap(12),
                CostumeFormField(
                  validationType: ValidationType.password,
                  controller: logic.passwordController,
                  hintText: "Password",
                  onChanged: () {
                    setState(() {});
                  },
                  labelText: "Password",
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
                const Gap(62),
                CostumeButtons.common(
                  labelText: logic.isUpdate?"Update User":"Add User",
                  onPressed: () {
                    logic.isUpdate?logic.updateUserDb(): logic.createUser();
                  },
                  isEnabled: logic.validateFields(),
                ),
              ],
            ),
          ));
    });
  }


  Widget _buildDropDownFormField({
    SingleValueDropDownController? controller,
    TextInputType? inputType,
    FocusNode? focusNode,
    String? hintText,
    VoidCallback? onChanged,
    required AddUserLogic mainController,
  }) {
    return DropDownTextField(
      controller: controller,
      onChanged: (a) {
        onChanged!();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: inputType ?? TextInputType.emailAddress,
      validator: (String? value) {
        return InputValidators.simpleValidation(value);
      },
      // textStyle: GoogleFonts.inter(color: ColorManager.textDark),
      // maxLength: maxLength ?? 36,
      textFieldFocusNode: focusNode,
      // obscureText: controller == mainController.passwordController ||controller == mainController.newPasswordController ||controller == mainController.confirmPasswordController||controller == mainController.confirmNewPasswordController,
      textFieldDecoration: InputDecoration(
        fillColor: ColorManager.white,
        filled: true,
        label: Text(hintText ?? ""),
        counterText: '',
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.textDark,
            ),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.errorOpacity50,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.errorOpacity50,
            ),
            borderRadius: BorderRadius.circular(10)),
        hintText: hintText ?? "",
        hintStyle: TextStyle(
          color: ColorManager.hintColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      dropDownList: mainController.userType,
    );
  }
}
