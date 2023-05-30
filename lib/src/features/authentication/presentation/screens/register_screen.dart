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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.redirectLocation, super.key});

  final String redirectLocation;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          context.goNamed(widget.redirectLocation);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(AppMargins.regularMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Row(
                children: [
                  Text('Sign', style: AppTheme.theme.textTheme.headlineLarge),
                  Text(
                    ' Up',
                    style: AppTheme.theme.textTheme.headlineLarge
                        ?.copyWith(color: AppColors.primary),
                  )
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: passwordController,
                validator: validatePassword,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              CustomButton.primary(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    RegisterWithEmailAndPass(
                      email: emailController.text,
                      password: passwordController.text,
                      displayName: displayNameController.text,
                    ),
                  );
                },
                text: 'Register',
              ),
              const SizedBox(height: 24),
              const AuthenticationDivider(),
              const SizedBox(height: 24),
              CustomButton(
                textColor: Colors.black87,
                backgroundColor: Colors.white,
                onPressed: () => BlocProvider.of<AuthBloc>(context)
                    .add(RegisterWithGoogle()),
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
                    onTap: () => context.goNamed(RouteNames.login),
                    child: const Text(
                      'Login',
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

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password is invalid';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
