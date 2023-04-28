import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/views/login_screen.dart';
import 'package:trivia_app/src/features/authentication/views/register_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const String register = 'register';
  static const String login = 'login';

  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          if (true) {
            return const LoginScreen();
          } else {
            return RegisterScreen();
          }
        },
      ),
      GoRoute(
        path: '/register',
        name: register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      )
    ],
  );
}
