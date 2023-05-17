import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);
      await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
