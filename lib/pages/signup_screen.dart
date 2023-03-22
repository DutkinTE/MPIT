// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mpit/models/user_model.dart';
import 'package:mpit/scripts/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isHiddenPassword = true;
  TextEditingController firstNameTextInputController = TextEditingController();
  TextEditingController secondNameTextInputController = TextEditingController();
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();
    firstNameTextInputController.dispose();
    secondNameTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    PostDetailsToFirestore();

    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // ignore: non_constant_identifier_names
  PostDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameTextInputController.text;
    userModel.secondName = secondNameTextInputController.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(196, 202, 224, 1),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Center(
                      child: Text(
                    'Регистрация',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'montserrat'),
                  )),
                ),
                const SizedBox(
                  height: 130,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: firstNameTextInputController,
                  autocorrect: false,
                  validator: (firstName) =>
                      firstName != null && firstName.isEmpty
                          ? 'Введите Имя'
                          : null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Имя',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: secondNameTextInputController,
                  autocorrect: false,
                  validator: (secondname) =>
                      secondname != null && secondname.isEmpty
                          ? 'Введите Фамилию'
                          : null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'comfortaa'),
                    hintText: 'Фамилия',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'comfortaa'),
                    hintText: 'Введите Email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autocorrect: false,
                  controller: passwordTextInputController,
                  obscureText: isHiddenPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'comfortaa'),
                    hintText: 'Введите пароль',
                    suffix: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autocorrect: false,
                  controller: passwordTextRepeatInputController,
                  obscureText: isHiddenPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'comfortaa'),
                    hintText: 'Введите пароль еще раз',
                    suffix: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromRGBO(150, 166, 192, 1))),
                  onPressed: signUp,
                  child: const SizedBox(
                      height: 34,
                      width: 345,
                      child: Center(
                          child: Text(
                        'Сохранить',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'comfortaa'),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
