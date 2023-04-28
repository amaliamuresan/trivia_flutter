import 'package:flutter/material.dart';
import 'package:trivia_app/src/style/style.dart';

class AuthenticationDivider extends StatelessWidget {
  const AuthenticationDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Flexible(
          child: Divider(
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargins.regularMargin),
          child: Text('or', style: TextStyle(color: AppColors.greyLight)),
        ),
        Flexible(
          child: Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }
}
