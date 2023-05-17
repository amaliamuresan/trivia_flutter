import 'package:flutter/cupertino.dart';
import 'package:trivia_app/src/style/style.dart';

class UserStatisticsWidget extends StatelessWidget {
  const UserStatisticsWidget(
      {required this.upperText, required this.lowerText, super.key});

  final String upperText;
  final String lowerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          upperText,
          style: const TextStyle(color: AppColors.primary),
        ),
        const SizedBox(height: AppMargins.extraSmallMargin),
        Text(
          lowerText,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
