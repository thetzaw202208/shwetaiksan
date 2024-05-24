import 'package:flutter/material.dart';
import 'package:shwetaiksan/constants/color_const.dart';
import 'package:shwetaiksan/constants/dimens.dart';
import 'package:shwetaiksan/constants/font.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {super.key,
      required this.controller,
      this.hintText,
       this.inputType,
      this.tColor,
      this.fontWeight,
      this.fontSize,
      this.height, this.width, this.radius, required this.onChanged, this.obscure, this.suffixWidget, this.prefixWidget});
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? inputType;
  final Color? tColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? radius;
  final Function(String) onChanged;
  final bool? obscure;
  final Widget? suffixWidget;
  final Widget? prefixWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(radius??smallBorder),
      child: SizedBox(
        height: height ?? 50,
        width: width??MediaQuery.of(context).size.width,
        child: TextField(
          obscureText: obscure??false,
          controller: controller,
      onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            fillColor: whiteColor,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
                fontSize: font14,
              ),
              contentPadding: const EdgeInsets.only(
                  top: defaultPadding,
                  right: defaultPadding,
                  left: defaultPadding),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(radius??smallBorder))),
          keyboardType: inputType??TextInputType.text,
          style: TextStyle(
      
              color: tColor ?? Colors.black,
              fontWeight: fontWeight ?? normal,
              fontSize: fontSize ?? font14),
        ),
      ),
    );
  }
}
