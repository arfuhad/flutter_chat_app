import 'package:flutter/material.dart';

class UIEditText extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final double? labelFontSize;
  final Color? labelColor;
  final FontWeight? labelFontWeight;
  final String? hintText;
  final double? hintFontSize;
  final Color? hintColor;
  final FontWeight? hintFontWeight;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? errorFontSize;
  final Color? errorColor;
  final bool obsecureText;
  final BoxDecoration? boxDecoration;
  final double paddingTop;
  final double paddingBottom;
  final double paddingRight;
  final double paddingLeft;
  final bool isShowBorderEnable;
  final Color? borderEnableColor;
  final bool isShowBorderFocused;
  final Color? borderFocusedColor;
  final int? minLine;
  final int? maxLine;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextInputType? keyboardType;
  final dynamic onChanged;
  final String? Function(String?)? validator;

  const UIEditText(
      {super.key,
      this.labelText,
      this.labelFontSize,
      this.labelColor,
      this.labelFontWeight,
      this.hintText,
      this.hintFontSize,
      this.hintColor,
      this.hintFontWeight,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.errorFontSize,
      this.errorColor,
      this.obsecureText = false,
      this.boxDecoration,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.paddingTop = 0,
      this.paddingBottom = 0,
      this.paddingRight = 0,
      this.paddingLeft = 0,
      this.borderEnableColor,
      this.borderFocusedColor,
      this.minLine = 1,
      this.maxLine = 1,
      this.prefixWidget,
      this.suffixWidget,
      this.isShowBorderEnable = true,
      this.isShowBorderFocused = true,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop,
          bottom: paddingBottom),
      decoration: boxDecoration,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obsecureText,
        minLines: minLine,
        maxLines: maxLine,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: labelText ?? "",
            labelStyle: TextStyle(
                fontSize: labelFontSize ?? 14,
                color: labelColor ?? Colors.black,
                fontWeight: labelFontWeight),
            hintText: hintText ?? "",
            hintStyle: TextStyle(
                fontSize: hintFontSize ?? 14,
                color: hintColor ?? Colors.black,
                fontWeight: hintFontWeight),
            errorStyle: TextStyle(
                fontSize: errorFontSize ?? 14, color: errorColor ?? Colors.red),
            enabledBorder: isShowBorderEnable
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: borderEnableColor ?? Colors.grey.shade300),
                  )
                : InputBorder.none,
            focusedBorder: isShowBorderFocused
                ? UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: borderFocusedColor ?? Colors.grey),
                  )
                : InputBorder.none,
            suffix: suffixWidget,
            prefix: prefixWidget),
        style: TextStyle(
            fontSize: fontSize ?? 14,
            color: fontColor ?? Colors.black,
            fontWeight: fontWeight),
        validator: validator,
      ),
    );
  }
}
