import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/app_managers/color_manager.dart';
import '../../core/enums/validation_type.dart';
import '../../core/helper/input_validator.dart';
import '../widgets/arrow_clip.dart';
import '../widgets/buttons.dart';
import '../widgets/input_fields.dart';
import 'dispatch_machine_logic.dart';

class DispatchMachinePage extends StatefulWidget {
  const DispatchMachinePage({super.key});

  @override
  State<DispatchMachinePage> createState() => _DispatchMachinePageState();
}

class _DispatchMachinePageState extends State<DispatchMachinePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DispatchMachineLogic>(builder: (logic) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Dispatch Machine"),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(12),
                ClipPath(
                  clipper: ArrowClipReversed(8),
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 20),
                      child: Text(
                        "STATUS DETAILS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildDropDownFormField(
                      hintText: "Status",
                      inputType: TextInputType.text,
                      mainController: logic,
                      onChanged: () {
                        setState(() {});
                      },
                      controller: logic.statusController),
                ),
                Gap(12),
                ClipPath(
                  clipper: ArrowClipReversed(8),
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 20),
                      child: Text(
                        "RENT DETAILS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      CostumeFormField(
                        validationType: ValidationType.name,
                        controller: logic.dispatchedToController,
                        hintText: "Dispatched To",
                        onChanged: () {
                          setState(() {});
                        },
                        labelText: "Dispatched To",
                      ),
                      Gap(12),
                      CostumeFormField(
                        validationType: ValidationType.phone,
                        inputType: TextInputType.phone,
                        controller: logic.userContactController,
                        hintText: "User Contact",
                        onChanged: () {
                          setState(() {});
                        },
                        labelText: "User Contact",
                      ),
                      Gap(12),
                      CostumeFormField(
                        validationType: ValidationType.common,
                        controller: logic.siteInfoController,
                        hintText: "Enter sight information",
                        onChanged: () {
                          setState(() {});
                        },
                        labelText: "Sight information",
                      ),
                    ],
                  ),
                ),
                Gap(12),
                ClipPath(
                  clipper: ArrowClipReversed(8),
                  child: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 20),
                      child: Text(
                        "TIMMING",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            logic.startDateController.text="sssss";
                            setState(() {
                            });
                          },
                          child: CostumeFormField.date(
                            validationType: ValidationType.date,
                            controller: logic.startDateController,
                            hintText: "Start date",
                            onChanged: () {
                              setState(() {});
                            },
                            labelText: "Start date",
                          ),
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CostumeFormField.date(
                          validationType: ValidationType.date,
                          controller: logic.endDateController,
                          hintText: "End date",
                          onChanged: () {
                            setState(() {});
                          },
                          labelText: "End date",
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CostumeButtons.common(
                    labelText: 'Submit',
                    onPressed: () {
                      logic.updateMachine();
                    },
                    isEnabled: logic.isFormValid(),
                  ),
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
    required DispatchMachineLogic mainController,
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
      dropDownList: mainController.status,
    );
  }
}
