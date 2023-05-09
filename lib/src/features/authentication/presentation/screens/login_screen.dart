import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/constants/assets_paths.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/widgets/authentication_divider.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/colors.dart';
import 'package:trivia_app/src/style/margins.dart';
import 'package:trivia_app/src/style/theme.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.redirectLocation,
    super.key,
  });

  final String redirectLocation;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          context.goNamed(widget.redirectLocation);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppMargins.regularMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Row(
                children: [
                  Text('Welcome back', style: AppTheme.theme.textTheme.headlineLarge),
                  Text(
                    '!',
                    style: AppTheme.theme.textTheme.headlineLarge?.copyWith(color: AppColors.primary),
                  )
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                controller: emailController,
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
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    LogInWithEmailAndPass(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
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
                      context.goNamed(RouteNames.register);
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
      ),
    );
  }
}
