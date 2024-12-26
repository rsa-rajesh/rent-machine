import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLine;
  final double? lineHeight;
  final TextOverflow? textOverflow;
  final Paint? foreground;
  const CustomText({
    required this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLine,
    this.lineHeight,
    this.textOverflow,
    super.key,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: textOverflow,
      // style: GoogleFonts.inter(
      //     fontSize: fontSize ?? 16,
      //     color: color ?? ColorManager.bodyB1,
      //     fontWeight: fontWeight ?? FontWeight.w500,
      //     height: lineHeight,
      //     foreground: foreground)
    );
  }
}
