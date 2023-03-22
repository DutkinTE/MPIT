import 'package:flutter/material.dart';


class DescriptionScreen extends StatefulWidget {
  String name = '';
  String events = '';
  String info = '';
  String list = '';
  String responsible = '';
  DescriptionScreen(
      {super.key,
      required this.name,
      required this.events,
      required this.info,
      required this.list,
      required this.responsible,});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState(name, events, info, list, responsible);
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  String name = '';
  String info = '0';
  String events = '';
  String list = '';
  String responsible = '';
  _DescriptionScreenState(
      this.name, this.events, this.info, this.list, this.responsible);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Text(name),
        Text(info),
        Text(events),
        Text(list),
        Text(responsible)
      ]),
    );
  }
}