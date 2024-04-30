import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils.dart';

class BorderedTextField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final TextAlign textAlign;
  final double? fontSize;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool enabled;
  final double borderRadius;
  final ValueChanged<String>? onFieldSubmitted;
  final Color? primaryColor;
  final int? maxLines;
  final bool autofocus;
  final bool validate;
  final FormFieldSetter<String>? onSaved;
  final bool? filled;
  final TextStyle? hintStyle;
  final Widget? label;
  final Color? backgroundColor;
  final Color borderLineColor;
  final Color? cursorColor;
  final TextCapitalization textCapitalization;
  final bool requiredValidator;
  final bool validateMobileNumber;
  final bool validatePassword;
  final bool addBorder;
  final bool noBorder;
  final bool showPassword;
  final bool readOnly;
  final String? errorText;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final Function(String)? countryCode;
  final String initialCountryCodeSelection;
  final bool validateDominicanNumber;
  final bool selectCountryCode;
  final TextStyle? labelStyle;
  final bool isWidthActivated;

  const BorderedTextField(
      {super.key, this.validator,
      this.borderRadius = 0.0,
      this.validatePassword = false,
      this.hintStyle,
      this.noBorder = false,
      this.contentPadding,
      this.isWidthActivated = false,
      required this.controller,
      this.labelStyle,
      this.addBorder = true,
      this.textCapitalization = TextCapitalization.none,
      this.onSaved,
      this.onTap,
      this.validateMobileNumber = false,
      this.filled,
      this.cursorColor,
      this.borderLineColor = Colors.grey,
      this.backgroundColor,
      this.label,
      this.validate = true,
      this.primaryColor,
      this.onFieldSubmitted,
      this.enabled = true,
      this.obscureText = false,
      this.autofocus = false,
      this.hintText = '',
      this.maxLines = 1,
      this.onChanged,
      this.inputFormatters,
      this.inputType,
      this.suffixIcon,
      this.fontSize,
      this.prefixIcon,
      this.textAlign = TextAlign.left,
      this.requiredValidator = true,
      this.showPassword = false,
      this.readOnly = false,
      this.errorText,
      this.textInputAction = TextInputAction.done,
      this.countryCode,
      this.validateDominicanNumber = false,
      this.selectCountryCode = true, required this.initialCountryCodeSelection});

  @override
  State<BorderedTextField> createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      onSaved: widget.onSaved,
      validator: widget.validator ??
          (!widget.requiredValidator
              ? null
              : (value) {
                  if (value.toString().trim().isEmpty) {
                    return '***Campo requerido';
                  } else if (widget.inputType == TextInputType.emailAddress) {
                    if (!Utils.validateEmail(value.toString())) {
                      return '***Correo invalido';
                    }
                  } else if (widget.validateDominicanNumber) {
                    if (value.toString().length < 10) {
                      return '***Número de télefono invalido';
                    } else {
                      String firstThreeNumber = value!.substring(0, 3);
                      if (firstThreeNumber.contains('809') ||
                          firstThreeNumber.contains('829') ||
                          firstThreeNumber.contains('849')) {
                        return null;
                      } else {
                        return '***Número invalido, debe de contener 809, 829 o 849';
                      }
                    }
                  }
                  return null;
                }),
      autofocus: widget.autofocus,
      keyboardType: widget.inputType,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      textAlign: widget.textAlign,
      cursorColor: widget.cursorColor,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters ?? (widget.validateMobileNumber
              ? [
                  Utils.onlyNumber(),
                  LengthLimitingTextInputFormatter(10),
                ]
              : widget.inputType == TextInputType.phone ||
                      widget.inputType == TextInputType.number
                  ? [
                      Utils.onlyNumber(),
                    ]
                  : widget.inputFormatters),
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      textCapitalization: widget.textCapitalization,
      style: TextStyle(fontSize: widget.fontSize),
      decoration: InputDecoration(
        labelStyle: widget.labelStyle,
        filled: widget.filled,
        label: widget.label,
        contentPadding: widget.contentPadding,
        fillColor: widget.backgroundColor,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        enabled: widget.enabled,
        // prefixIcon:
        //     widget.inputType == TextInputType.phone && widget.selectCountryCode
        //         ? BuildCountryCodePicker(
        //             onInit: (code) {
        //               if (widget.countryCode != null) {
        //                 widget.countryCode!(code.toString());
        //               }
        //             },
        //             onChanged: (code) {
        //               if (widget.countryCode != null) {
        //                 widget.countryCode!(code.toString());
        //               }
        //             },
        //             initialSelection: widget.initialCountryCodeSelection,
        //           )
        //         : widget.prefixIcon,
        errorText: widget.errorText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(obscureText
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeLowVision))
            : widget.suffixIcon,
//            contentPadding: EdgeInsets.symmetric(
//              horizontal: 10,
//              vertical: 5,
//            ),
        disabledBorder: widget.addBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderLineColor,
                    width: widget.isWidthActivated ? 2 : 1),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              )
            : widget.noBorder
                ? InputBorder.none
                : null,
        enabledBorder: widget.addBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    color: widget.primaryColor ?? Colors.red,
                    width: widget.isWidthActivated ? 2 : 1),
              )
            : widget.noBorder
                ? InputBorder.none
                : null,
        border: widget.addBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              )
            : widget.noBorder
                ? InputBorder.none
                : null,
        focusedBorder: widget.addBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderLineColor,
                    width: widget.isWidthActivated ? 2 : 1),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              )
            : widget.noBorder
                ? InputBorder.none
                : null,
      ),
    );
  }
}
