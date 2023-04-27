import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/authentication/views/register_screen.dart';
import 'package:trivia_app/src/style/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const RegisterScreen(),
    );
  }
}
