// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mpit/const/admin.dart';
import 'package:mpit/models/user_model.dart';
import 'package:mpit/widgets/add_body.dart';

import '../widgets/account_body.dart';
import '../widgets/main_body.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
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
          backgroundColor: Colors.white,
          body: Center(child: Text('Подождите')));
    };
    return Scaffold(
      drawer: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
          bottom: 300,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Drawer(
            backgroundColor: Color.fromRGBO(151, 114, 92, 1),
            width: 200,
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
              Radius.circular(17),
            ),
            child: admin.contains(user!.email)
                ? BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Color.fromRGBO(83, 82, 82, 1),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline, color: Colors.white),
                          label: '')
                    ],
                    iconSize: 30,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                  )
                : BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Color.fromRGBO(83, 82, 82, 1),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline, color: Colors.white),
                          label: '')
                    ],
                    iconSize: 30,
                    currentIndex: selectedIndex,
                    onTap: _onItemTapped,
                  )),
      ),
      body: body_main[selectedIndex],
    );
  }
}
