// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mpit/data/admin.dart';
import 'package:mpit/data/colors.dart';
import 'package:mpit/models/user_model.dart';
import 'package:mpit/pages/chats_screen.dart';
import 'package:mpit/pages/list_screen.dart';
import 'package:mpit/var/var.dart';
import 'package:mpit/widgets/add_body.dart';

import '../widgets/account_body.dart';
import '../widgets/main_body.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> body_main = [MainBody(), AccountBody()];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    if (admin.contains(user!.email)) {
      body_main = [MainBody(), AddBody(), AccountBody()];
    }

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      return const Scaffold(
          backgroundColor: Color.fromRGBO(27, 31, 39, 1),
          body: Center(child: Text('Подождите')));
    };
    return Scaffold(
      backgroundColor: background,
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
          left: 30,
          right: 30,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: admin.contains(user!.email)
                ? BottomNavigationBar(
                    unselectedItemColor: textColor,
                    selectedItemColor: enableColor,
                    backgroundColor: appColor,
                    selectedLabelStyle: TextStyle(fontSize: 10, fontFamily: 'comfortaa'),
                    unselectedLabelStyle: TextStyle(fontSize: 10, fontFamily: 'comfortaa'),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map_outlined),
                        label: 'Карта',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.add,
                          ),
                          label: 'Добавить'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline),
                          label: 'Пользователь')
                    ],
                    iconSize: 30,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                  )
                : BottomNavigationBar(
                    unselectedItemColor: textColor,
                    selectedItemColor: enableColor,
                    backgroundColor: Color.fromRGBO(93, 118, 149, 1),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_outlined,
                          ),
                          label: 'Карта'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map_outlined),
                          label: 'Пользователь')
                    ],
                    iconSize: 30,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                  )),
      ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: appColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListScreen()));
                },
                child: Text('Кабинеты',
                    style: TextStyle(
                        fontSize: 17,
                        color: textColor,
                        fontFamily: 'comfortaa')),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                child: Text('Чат',
                    style: TextStyle(
                        fontSize: 17,
                        color: textColor,
                        fontFamily: 'comfortaa')),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                child: Text('Меню',
                    style: TextStyle(
                        fontSize: 17,
                        color: textColor,
                        fontFamily: 'comfortaa')),
              )
            ],
          )),
      body: body_main[selectedIndex],
    );
  }
}
