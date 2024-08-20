import 'package:flutter/material.dart';

import '../../core/app_managers/color_manager.dart';


class CostumeButtons extends StatefulWidget {
  final String labelText;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool isEnabled;
  final String btnType;

  const CostumeButtons.common(
      {super.key,
      required this.labelText,
      this.onPressed,
      this.onLongPressed,
      required this.isEnabled,
      this.btnType = "common"});

  const CostumeButtons.positive(
      {super.key,
      required this.labelText,
      this.onPressed,
      this.onLongPressed,
      required this.isEnabled,
      this.btnType = "positive"});

  const CostumeButtons.negative(
      {super.key,
      required this.labelText,
      this.onPressed,
      this.onLongPressed,
      required this.isEnabled,
      this.btnType = "negative"});

  @override
  State<CostumeButtons> createState() => _CostumeButtonsState();
}

class _CostumeButtonsState extends State<CostumeButtons> {
  var passSeen = false;
  Color foregroundColor = Colors.white;
  Color backgroundColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    if (widget.btnType == "positive") {
      foregroundColor = ColorManager.positiveButtonForegroundColor;
      backgroundColor = ColorManager.positiveButtonBackgroundColor;
    } else if (widget.btnType == "negative") {
      foregroundColor = ColorManager.negativeButtonForegroundColor;
      backgroundColor = ColorManager.negativeButtonBackgroundColor;
    } else {
      foregroundColor = ColorManager.commonButtonForegroundColor;
      backgroundColor = ColorManager.commonButtonBackgroundColor;
    }

    return FilledButton(
      onPressed: widget.isEnabled
          ? () {
              widget.onPressed!();
            }
          : null,
      onLongPress: widget.isEnabled
          ? () {
              widget.onLongPressed!();
            }
          : null,
      style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Text(
        widget.labelText,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.isEnabled ? foregroundColor : null),
      ),
    );
  }
}
