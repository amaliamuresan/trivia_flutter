import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:trivia_app/src/features/home/presentation/pages/home_page.dart';
import 'package:trivia_app/src/features/main/presentation/main_screen.dart';
import 'package:trivia_app/src/features/quiz_menu/data/open_trivia_repository.dart';
import 'package:trivia_app/src/features/search/presentation/pages/search_page.dart';

part 'route_names.dart';

class AppRoutes {
  const AppRoutes._();

  static final GoRouter routes = GoRouter(
    redirect: (context, state) {
      print('We are on location ${state.location} with name ${state.name}');
      final authBloc = BlocProvider.of<AuthBloc>(context);
      final isAuthenticated = authBloc.state.isAuthenticated;
      final isOnLogin = state.location == RouteLocations.login;
      final isOnSignUp = state.location == RouteLocations.register;
      final isOnIndex = state.location == '/index';

      if (kDebugMode) {
        print(isAuthenticated);
      }
      if (!isAuthenticated && !isOnSignUp && !isOnLogin) {
        return '/${RouteNames.login}';
      } else if ((isOnSignUp || isOnLogin || isOnIndex) && isAuthenticated) {
        return '/${RouteNames.home}';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'index',
        pageBuilder: (context, state) {
          /// this might be useless because we redirect above.
          return const NoTransitionPage(
            child: MainScreen(
              child: HomePage(),
            ),
          );
        },
        // builder: (BuildContext context, GoRouterState state) {
        //   // if (true) {
        //   //   return const LoginScreen();
        //   // } else {
        //   //   return RegisterScreen();
        //   // }
        //   /// Maybe splash screen??
        //   // return const HomePage();
        //   return NoTransitionPage(
        //     child: MainScreen(
        //       child: HomePage(),
        //     ),
        //   );
        // },
      ),
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen(
            redirectLocation: RouteNames.home,
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen(
            redirectLocation: RouteNames.home,
          );
        },
      ),
      _mainRoutes,
      GoRoute(
        path: RouteLocations.search,
        name: RouteNames.search,
        builder: (BuildContext context, GoRouterState state) {
          return const SearchPage();
        },
      ),
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
          return NoTransitionPage(
            child: MainScreen(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('More'),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            LogOut(() {
                              context.go(r'\');
                            }),
                          );
                        },
                        child: const Text('Sign out'),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          await OpenTriviaRepository().getQuestions();
                        },
                        child: const Text('Request'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
