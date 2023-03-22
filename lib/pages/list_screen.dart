// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpit/pages/description.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(196, 202, 224, 1),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cabinet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                itemCount: snapshot.requireData.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionScreen(
                                  name: snapshot.requireData.docs[index]
                                      ['name'],
                                  events: snapshot.requireData.docs[index]
                                      ['events'],
                                  info: snapshot.requireData.docs[index]
                                      ['info'],
                                  list: snapshot.requireData.docs[index]
                                      ['list'],
                                  responsible: snapshot.requireData.docs[index]
                                      ['responsible'],
                                      id: snapshot.requireData.docs[index].id,
                                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(123, 142, 173, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: SizedBox(
                              height: 50,
                              child: Center(
                                  child: Text(snapshot.requireData.docs[index]
                                      ['name'], style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontFamily: 'comfortaa'))))),
                    ),
                  );
                }),
          );
        })
    );
  }
}