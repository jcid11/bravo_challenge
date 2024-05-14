import 'package:bravo_challenge/utils/theme.dart';
import 'package:flutter/material.dart';

extension AppStyle on BuildContext{
  InputDecoration? get textFieldInputDecoration =>ThemeApp.textInputDecoration;
  TextStyle? get loginTextStyle=>ThemeApp.loginTextStyle;
  TextStyle? get listTextStyle=>Theme.of(this).textTheme.bodyMedium;
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toPesos(){
    return '\$$this.00DOP';
  }

  int stringDoubleToInt()=>int.parse(split('.')[0]);

}

extension DecimalRound on double {
  double toPrecision() => double.parse(toStringAsFixed(2));

  int doubleToInt()=>int.parse(toString().split('.')[0]);
}

extension Convertion on num{
  double decimalConversion()=>double.parse(toString()).toPrecision();
}