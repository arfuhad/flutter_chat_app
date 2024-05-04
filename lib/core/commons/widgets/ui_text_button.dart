import 'package:flutter/material.dart';

class UiTextButton extends StatelessWidget {
  const UiTextButton(
      {super.key,
      required this.onPressedFn,
      required this.buttonText,
      this.buttonTextAlign,
      this.buttonColor,
      this.buttonElevation,
      this.buttonBorderRadius,
      this.buttonSize,
      this.fontWeight,
      this.fontSize,
      this.fontColor,
      this.buttonBorderColor});

  final VoidCallback onPressedFn;
  final String buttonText;
  final TextAlign? buttonTextAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Size? buttonSize;
  final double? buttonElevation;
  final Color? buttonBorderColor;
  final double? buttonBorderRadius;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressedFn,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(buttonElevation ?? 0),
          fixedSize:
              MaterialStateProperty.all(buttonSize ?? const Size(150, 30)),
          backgroundColor: MaterialStateProperty.all<Color>(
            buttonColor ?? Colors.indigo,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonBorderRadius ?? 10),
            ),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: buttonTextAlign ?? TextAlign.center,
            style: TextStyle(
              color: fontColor ?? Colors.black,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ));
  }
}
