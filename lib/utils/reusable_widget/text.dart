import 'package:flutter/material.dart';

import '../theme.dart';

class BuildText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;

  const BuildText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.color,
      this.decoration,
      this.maxLines,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? ThemeApp.primaryColor,
          decoration: decoration),
      textAlign: textAlign,
    );
  }
}
