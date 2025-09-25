import 'package:codeme_task/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextformFieldWidget extends StatelessWidget {
  const TextformFieldWidget(
      {super.key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.controller,
      this.obscureText = false});

  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: KAppColors.kFillColor,
        hintStyle: TextStyle(color: KAppColors.hintColor),
        labelStyle: TextStyle(
          color: KAppColors.labelColor,
        ),
        // Border when the field is enabled (not focused)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        // Border when the field is focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
