// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  String name = '';
  String events = '';
  String id = '';
  String info = '';
  String list = '';
  String responsible = '';
  DescriptionScreen({
    super.key,
    required this.name,
    
    required this.events,
    required this.info,
    required this.list,
    required this.responsible,
    required this.id,
  });

  @override
  State<DescriptionScreen> createState() =>
      _DescriptionScreenState(name, events, info, list, responsible, id);
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  String name = '';
  String info = '';
  String events = '';
  String id = '';
  String list = '';
  String responsible = '';
  _DescriptionScreenState(
      this.name,  this.events, this.info, this.list, this.responsible, this.id,);
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        backgroundColor: Color.fromRGBO(196, 202, 224, 1),
        body: Column(children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Container(
                  height: 650,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(123, 142, 173, 1),
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                  child: Column(children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(150, 166, 192, 1),
                              width: 3),
                          color: Color.fromRGBO(93, 118, 149, 1),
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: 'comfortaa'),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('cabinet')
                                      .doc(id)
                                      .delete();
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ))
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.person_outline,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(responsible,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'comfortaa'))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(info,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'comfortaa'))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.monitor_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(list,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'comfortaa')),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 420,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(93, 118, 149, 1),
                          borderRadius: BorderRadius.all(Radius.circular(17))),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(150, 166, 192, 1),
                                    width: 3),
                                color: Color.fromRGBO(93, 118, 149, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17))),
                            child: Center(
                                child: Text(
                              'События',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'comfortaa'),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Text(events,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'comfortaa')),
                          )
                        ],
                      ),
                    ),
                  ])),
            ),
          ),
        ]));
  }
}
