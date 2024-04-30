import 'package:flutter/material.dart';

class ThemeApp {
  static get themeDataPrimary => (BuildContext context) {
        return ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: secondaryColor,fontWeight: FontWeight.w600)
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(primaryColor))),
          buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
          scaffoldBackgroundColor:secondaryColor,
          appBarTheme:  const AppBarTheme(
              foregroundColor: primaryColor, backgroundColor: secondaryColor),
        );
      };

  static InputDecoration textInputDecoration = InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ThemeApp.primaryColor,
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ThemeApp.greyTextColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ThemeApp.greyTextColor)),
      hintStyle: const TextStyle(fontSize: 14, color: ThemeApp.greyTextColor));

  static Widget appPadding({required Widget child}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: child,
      );

  static  BorderRadius generalBorderRadius = BorderRadius.circular(12);

  static const TextStyle loginTextStyle =
      TextStyle(fontSize: 13, color: ThemeApp.primaryColor);

  static const Color primaryColor = Color(0xff66bfbf);
  static const Color secondaryColor = Color(0xfffcfefe);
  static const Color greyTextColor = Color(0xffd9d9d9);
}
