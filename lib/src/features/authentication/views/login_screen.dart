import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/constants/assets_paths.dart';
import 'package:trivia_app/src/features/authentication/widgets/authentication_divider.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/colors.dart';
import 'package:trivia_app/src/style/margins.dart';
import 'package:trivia_app/src/style/theme.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppMargins.regularMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Row(
              children: [
                Text('Welcome back',
                    style: AppTheme.theme.textTheme.headlineLarge),
                Text(
                  '!',
                  style: AppTheme.theme.textTheme.headlineLarge
                      ?.copyWith(color: AppColors.primary),
                )
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 24),
            CustomButton.primary(
              onPressed: () {},
              text: 'Login',
            ),
            const SizedBox(height: 24),
            const AuthenticationDivider(),
            const SizedBox(height: 24),
            CustomButton.outlined(
              onPressed: () {},
              text: 'Login with Google',
              leadingIcon: Image.asset(AssetsPaths.googleIcon),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.register);
                  },
                  child: const Text(
                    'Register',
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
}
