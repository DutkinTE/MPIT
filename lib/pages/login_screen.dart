// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mpit/data/colors.dart';
import 'package:mpit/scripts/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Неправильный email или пароль. Повторите попытку',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
        return;
      }
    }

    navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 80),
                child: Center(
                    child: Text(
                  'Войдите\nпо электронной почте',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      height: 1.3,
                      fontFamily: 'comfortaa',
                      color: Color.fromRGBO(176, 182, 189, 1)),
                  textAlign: TextAlign.center,
                )),
              ),
              TextFormField(
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите правильный Email'
                        : null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(176, 182, 189, 1),
                      fontSize: 16,
                      fontFamily: 'comfortaa'),
                  hintText: 'Введите эл.почту',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: TextStyle(color: textColor),
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(176, 182, 189, 1),
                      fontSize: 16,
                      fontFamily: 'comfortaa'),
                  hintText: 'Пароль',
                  suffix: GestureDetector(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mapColor)),
                onPressed: login,
                child: const SizedBox(
                    height: 34,
                    width: 221,
                    child: Center(
                        child: Text(
                      'Войти',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'comfortaa'),
                    ))),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/signup'),
                child: Text(
                  'Регистрация',
                  style: TextStyle(
                      color: Color.fromRGBO(176, 182, 189, 1),
                      fontFamily: 'comfortaa',
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/reset_password'),
                child: Text(
                  'Сбросить пароль',
                  style: TextStyle(
                      color: Color.fromRGBO(176, 182, 189, 1),
                      fontFamily: 'comfortaa',
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
