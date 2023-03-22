import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpit/pages/description.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  int currentIndex = 0;
  List<Widget> maps = [
    SvgPicture.asset('lib/assets/images/Group 389.svg'),
    SvgPicture.asset('lib/assets/images/Group 389.svg'),
    SvgPicture.asset('lib/assets/images/Group 389.svg'),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cabinet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Stack(
            children: [
              
              Center(child: maps[currentIndex]),
              Padding(
                padding: const EdgeInsets.only(left: 300.0, top: 150),
                child: Container(
                  height: 120,
                  width: 50,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(123, 142, 173, 1)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                          
                        },
                        child: Container(
                          color: Colors.grey,
                          height: 40,
                           width: 50,
                          child: Center(child: Text('1')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                          
                        },
                        child: Container(
                          color: Colors.green,
                          height: 40,
                           width: 50,
                          child: Center(child: Text('2')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                          
                        },
                        child: Container(
                          color: Colors.blue,
                          height: 40,
                           width: 50,
                          child: Center(child: Text('3')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
