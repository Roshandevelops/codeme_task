import 'package:codeme_task/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    this.buttonText,
    this.onTap,
    this.backgroundColor = KAppColors.primaryColor,
    this.textColor = KAppColors.kwhite,
  });

  final String? buttonText;
  final void Function()? onTap;
  final Color? textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            buttonText ?? "",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
