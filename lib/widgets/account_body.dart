// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';


class AccountBody extends StatefulWidget {
  const AccountBody({super.key});

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
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
    if (loggedInUser.firstName == null){
      return Center(child: Text('Подождите'));
    }
    return ListView(
        children: [
          Container(height: 100,
          decoration: BoxDecoration(
            
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0
              ),
            ]
          ),  
          child: Column(
            children: [
              SizedBox(height: 50,),
          Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.person_outline, size: 35,),
              SizedBox(width: 15,),
              Text('${loggedInUser.firstName} ${loggedInUser.secondName}', style: TextStyle(fontSize: 16, fontFamily: 'montserrat', color: Color.fromRGBO(162, 162, 162, 1)),)
            ],
          ),
            ],
          ),),
          
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/account');
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                
                border: Border.all(width: 1, color: Color.fromRGBO(210, 210, 210, 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(width: 290,
                    child: Row(children: [SizedBox(width: 20,), Icon(Icons.edit_document, size: 35,),
                    SizedBox(width: 20,),
                  Text('Редактировать профиль', style: TextStyle(fontFamily: 'montserrat', fontSize: 16),),],),),
                  
                  SizedBox(
                    child: Row(children: [Icon(Icons.navigate_next, size: 35, color: Color.fromRGBO(210, 210, 210, 1)),
                    SizedBox(width: 20,),],),),
                ],),
              ),
          ),
        ],
      )
    ;
  }
}