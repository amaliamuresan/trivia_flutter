import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/colors.dart';
import 'package:trivia_app/src/style/margins.dart';

class GameLoadingWidget extends StatelessWidget {
  const GameLoadingWidget({super.key, required this.categoryName});

  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(categoryName),
        const SizedBox(height: AppMargins.regularMargin),
        const CircularProgressIndicator(color: AppColors.accentColor),
      ],
    );
  }
}
