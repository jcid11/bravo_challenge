import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';

class BuildCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? fontColor;
  final String text;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const BuildCustomButton(
      {Key? key,
      this.padding,
        required this.text,
        this.fontSize,
        this.fontColor,
      required this.onPressed,
      this.color,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius:borderRadius, color: color),
      child: RawMaterialButton(
        onPressed: onPressed,
        constraints: const BoxConstraints(minWidth: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape:  RoundedRectangleBorder(
            borderRadius:borderRadius??BorderRadius.zero ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: BuildText(text: text,color: fontColor,fontSize: fontSize,),
        ),
      ),
    );
  }
}
