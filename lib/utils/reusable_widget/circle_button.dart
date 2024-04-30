import 'package:flutter/material.dart';

class BuildCircleIconButton extends StatelessWidget {
  final Color? circleColor;
  final VoidCallback onPressed;
  final IconData icon;
  final Color? iconColor;
  final EdgeInsets padding;
  final double? iconSize;
  const BuildCircleIconButton({Key? key,  this.circleColor,required this.onPressed,required this.icon,this.iconColor,this.padding=const EdgeInsets.all(2.0),this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor),
      child: RawMaterialButton(
        constraints: const BoxConstraints(
            minWidth: 0),
        shape: const CircleBorder(),
        materialTapTargetSize:
        MaterialTapTargetSize
            .shrinkWrap,
        onPressed: onPressed,
        child:  Padding(
          padding: padding,
          child: Icon(
            icon,
            color: iconColor,
size: iconSize,
          ),
        ),
      ),
    );
  }
}
