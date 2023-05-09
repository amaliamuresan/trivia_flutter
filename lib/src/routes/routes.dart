import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:trivia_app/src/features/home/presentation/pages/home_page.dart';
import 'package:trivia_app/src/features/main/presentation/main_screen.dart';

part 'route_names.dart';

class AppRoutes {
  const AppRoutes._();

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
        name: RouteNames.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      _mainRoutes
    ],
  );

  static final _mainRoutes = ShellRoute(
    // navigatorKey: _shellMainNavigatorKey,
    builder: (context, state, child) {
      return Container(child: child);
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: MainScreen(
              child: HomePage(),
            ),
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        name: RouteNames.notifications,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: MainScreen(
              child: Center(
                child: Text(
                  'Notifications',
                ),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/more',
        name: RouteNames.more,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const NoTransitionPage(
            child: MainScreen(
              child: Center(
                child: Text('More'),
              ),
            ),
          );
        },
      ),
    ],
  );
}
