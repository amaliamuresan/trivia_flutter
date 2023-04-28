import 'package:flutter/material.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trivia App',
      theme: AppTheme.theme,
      routerConfig: AppRoutes.routes,
    );
  }
}
