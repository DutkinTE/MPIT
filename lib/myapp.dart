// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:mpit/pages/account_screen.dart';
import 'package:mpit/pages/firebase_stream.dart';
import 'package:mpit/pages/home_screen.dart';
import 'package:mpit/pages/login_screen.dart';
import 'package:mpit/pages/reset_password.dart';
import 'package:mpit/pages/signup_screen.dart';
import 'package:mpit/pages/verify_email_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: const Center(child: CircularProgressIndicator()));
    };
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => HomeScreen(),
        '/account': (context) => const AccountScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
      },
      initialRoute: '/',
    );
  }
}
