import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpit/pages/description.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                                      ['responsible'])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: SizedBox(
                              height: 30,
                              child: Center(
                                  child: Text(snapshot.requireData.docs[index]
                                      ['name'])))),
                    ),
                  );
                }),
          );
        });
  }
}
