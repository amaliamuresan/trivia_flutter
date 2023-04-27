import 'package:flutter/material.dart';
import 'package:trivia_app/src/constants/assets_paths.dart';
import 'package:trivia_app/src/style/colors.dart';
import 'package:trivia_app/src/style/margins.dart';
import 'package:trivia_app/src/style/theme.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppMargins.regularMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              children: [
                Text('Sign', style: AppTheme.theme.textTheme.headlineLarge),
                Text(
                  ' Up',
                  style: AppTheme.theme.textTheme.headlineLarge?.copyWith(color: AppColors.primary),
                )
              ],
            ),
            const SizedBox(height: 24),
            const TextField(decoration: InputDecoration(labelText: 'E-mail')),
            const SizedBox(height: 18),
            const TextField(decoration: InputDecoration(labelText: 'Username')),
            const SizedBox(height: 18),
            const TextField(decoration: InputDecoration(labelText: 'Password')),
            const SizedBox(height: 24),
            CustomButton.primary(
              onPressed: () {},
              text: 'Register',
            ),
            const SizedBox(height: 24),
            customDivider,
            const SizedBox(height: 24),
            CustomButton.outlined(
              onPressed: () {},
              text: 'Sign Up with Google',
              leadingIcon: Image.asset(AssetsPaths.googleIcon),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget get customDivider {
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
