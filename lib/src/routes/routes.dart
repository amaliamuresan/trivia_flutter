import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:trivia_app/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:trivia_app/src/features/home/presentation/pages/home_page.dart';
import 'package:trivia_app/src/features/main/presentation/main_screen.dart';
import 'package:trivia_app/src/features/notifications/presentation/pages/notifications_page.dart';
import 'package:trivia_app/src/features/quiz_match/presentation/screens/quiz_match_screen.dart';
import 'package:trivia_app/src/features/quiz_match/presentation/screens/quiz_page_screen.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/features/search/presentation/pages/search_page.dart';
import 'package:trivia_app/src/features/single_game/presentation/pages/single_game_page.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

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
      GoRoute(
        path: RouteLocations.quizPage,
        name: RouteNames.quizPage,
        builder: (BuildContext context, GoRouterState state) {
          final category = state.extra! as QuizCategory;
          return QuizPageScreen(category: category);
        },
      ),
      GoRoute(
        path: RouteLocations.quizMatch,
        name: RouteNames.quizMatch,
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(
            appBar: AppBar(toolbarHeight: 0),
              body: QuizMatchScreen(
            matchId: state.queryParams['matchId']!,
            isChallenger: state.queryParams['isChallenger']! == 'true',
          ));
        },
      ),
      GoRoute(
        path: RouteLocations.singleGame,
        name: RouteNames.singleGame,
        builder: (BuildContext context, GoRouterState state) {
          final category = state.extra! as QuizCategory;
          return SingleGamePage(quizCategory: category);
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
// <<<<<<< HEAD
//             child: MainScreen(
//               child: TempNotificationChallenges(),
//             ),
// =======
            child: MainScreen(child: NotificationsPage()),
// >>>>>>> master
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
                    SizedBox(
                      height: 45,
                      child: CustomButton.outlined(width: 200, text: 'Log Out', onPressed:  () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LogOut(() {
                            context.go(r'\');
                          }),
                        );
                      }),
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
