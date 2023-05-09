import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
