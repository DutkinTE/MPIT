// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text('Подождите')));
    };
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: ElevatedButton(child: Text('Аккаунт'), onPressed: (){
          Navigator.pushNamed(context, '/account');
        },),
      ),
    );
  }
}
