import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../core/app_managers/color_manager.dart';
import '../../core/enums/validation_type.dart';
import '../../core/helper/input_validator.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class CostumeFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final VoidCallback? onChanged;
  final ValidationType validationType;
  final bool? enableCounter;
  final bool? isSearch;
  final bool? enabled;

  final TextEditingController? passwordController;

  const CostumeFormField(
      {super.key,
      this.controller,
      this.inputType,
      this.focusNode,
      this.maxLength,
      this.hintText,
      this.onChanged,
      required this.validationType,
      this.labelText,
      this.prefixText,
      this.enableCounter,
      this.passwordController,
      this.isSearch = false,
      this.enabled = true});

  const CostumeFormField.confirmPassword({
    super.key,
    this.controller,
    this.inputType,
    this.focusNode,
    this.maxLength,
    this.hintText,
    this.onChanged,
    required this.validationType,
    this.labelText,
    this.prefixText,
    this.enableCounter,
    required this.passwordController,
    this.isSearch = false,
    this.enabled = true,
  });

  const CostumeFormField.date({
    super.key,
    this.controller,
    this.inputType,
    this.focusNode,
    this.maxLength,
    this.hintText,
    this.onChanged,
    required this.validationType,
    this.labelText,
    this.prefixText,
    this.enableCounter,
    this.passwordController,
    this.isSearch = false,
    this.enabled = false,
  });

  const CostumeFormField.search({
    super.key,
    this.controller,
    this.inputType,
    this.focusNode,
    this.maxLength,
    this.hintText,
    this.onChanged,
    required this.validationType,
    this.labelText,
    this.prefixText,
    this.enableCounter,
    this.passwordController,
    this.isSearch = true,
    this.enabled = true,
  });

  @override
  State<CostumeFormField> createState() => _CostumeFormFieldState();
}

class _CostumeFormFieldState extends State<CostumeFormField> {
  var passSeen = true;

  @override
  Widget build(BuildContext context) {
    // if (widget.validationType == ValidationType.password) {
    //   passSeen = true;
    // }

    return GestureDetector(
      onTap: () async{
        if (widget.validationType == ValidationType.date) {
          widget.controller?.text =  await getDate();
          widget.onChanged!();

        }
      },
      child: TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: (widget.validationType == ValidationType.password ||
                  widget.validationType == ValidationType.confirmPassword)
              ? passSeen
              : false,
          onChanged: (a) {
            // setState(() {
            // });
            widget.onChanged!();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.inputType ?? TextInputType.emailAddress,
          validator: (String? value) {
            if (widget.validationType == ValidationType.email) {
              return InputValidators.emailValidator(value);
            }
            if (widget.validationType == ValidationType.phone) {
              return InputValidators.mobileNumberValidator(value);
            }
            if (widget.validationType == ValidationType.password) {
              return InputValidators.passwordValidator(value);
            }
            if (widget.validationType == ValidationType.confirmPassword) {
              return InputValidators.confirmPasswordValidator(
                  value, widget.passwordController?.text);
            }

            return null;
          },
          style: TextStyle(color: ColorManager.textDark),
          maxLength: widget.maxLength ?? 36,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            fillColor: ColorManager.white,
            prefixText: widget.prefixText ?? "",
            filled: true,
            label: widget.labelText != null ? Text(widget.labelText!) : null,
            counterText:
                (widget.enableCounter != null && widget.enableCounter == true)
                    ? null
                    : "",
            suffixIconColor: HexColor.fromHex("#919BA7"),
            prefixIcon: widget.isSearch! ? const Icon(Icons.search) : null,
            suffixIcon: (widget.validationType == ValidationType.password ||
                    widget.validationType == ValidationType.confirmPassword)
                ? InkWell(
                    onTap: () {
                      passSeen = !passSeen;
                      setState(() {});
                      // widget.onChanged!();
                    },
                    child: passSeen
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined))
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.textDark,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(
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
            hintText: widget.hintText ?? "",
            hintStyle: TextStyle(
              color: ColorManager.hintColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            errorStyle: TextStyle(
              color: ColorManager.errorColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          onFieldSubmitted: (String val) {}),
    );
  }

  Future<String> getDate() async {
    NepaliDateTime? selectedDateTime = await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2080),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
    );
    if(selectedDateTime!=null){
      return selectedDateTime.toString().split(" ")[0];
    }else {
      return "";
    }
  }
}
