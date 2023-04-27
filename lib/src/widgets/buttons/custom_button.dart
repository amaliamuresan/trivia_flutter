import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.textColor,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.width = double.infinity,
    this.borderColor,
    this.leadingIcon,
    super.key,
  });

  const CustomButton.primary({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.purpleDark,
    this.width = double.infinity,
    this.borderColor,
    this.leadingIcon,
    super.key,
  });

  const CustomButton.outlined({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.textColor = AppColors.primary,
    this.width = double.infinity,
    this.borderColor = AppColors.greyLight,
    this.leadingIcon,
    super.key,
  });

  final Color textColor;
  final String text;
  final Color backgroundColor;
  final Color? borderColor;
  final void Function()? onPressed;
  final double? width;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor ?? backgroundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              SizedBox(height: 24, child: leadingIcon,),
              const SizedBox(
                width: 8,
              ),
            ],
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
