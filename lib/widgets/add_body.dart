import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpit/var/var.dart';

class AddBody extends StatefulWidget {
  const AddBody({super.key});

  @override
  State<AddBody> createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameTextInputController = TextEditingController();
  TextEditingController eventTextInputController = TextEditingController();
  TextEditingController infoTextInputController = TextEditingController();
  TextEditingController listTextInputController = TextEditingController();
  TextEditingController responsibleTextInputController = TextEditingController();
  @override
  void dispose() {
    nameTextInputController.dispose();
    eventTextInputController.dispose();
    infoTextInputController.dispose();
    listTextInputController.dispose();
    responsibleTextInputController.dispose();

    super.dispose();
  }
  Future<void> add() async {
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    await FirebaseFirestore.instance.collection('cabinet').add({
      'name': nameTextInputController.text,
      'events': eventTextInputController.text,
      'info': infoTextInputController.text,
      'list': listTextInputController.text,
      'responsible': responsibleTextInputController.text
    });
    setState(() {
      navigator.pushNamedAndRemoveUntil(
          '/home', (Route<dynamic> route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('slots').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Form(
            key: formKey,
            child: ListView(children: <Widget>[
              TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nameTextInputController,
                  autocorrect: false,
                  validator: (name) =>
                      name != null && name.isEmpty
                          ? 'Введите название'
                          : null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Название',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: eventTextInputController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Мероприятия',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: infoTextInputController,
                  autocorrect: false,
                  validator: (info) =>
                      info != null && info.isEmpty
                          ? 'Введите информацию'
                          : null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Информация',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: listTextInputController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Список оборудования',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: responsibleTextInputController,
                  autocorrect: false,
                  validator: (responsible) =>
                      responsible != null && responsible.isEmpty
                          ? 'Введите ответственного'
                          : null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.fromSTEB(50, 7, 0, 0),
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(162, 162, 162, 1),
                        fontSize: 16,
                        fontFamily: 'montserrat'),
                    hintText: 'Ответственный',
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color.fromRGBO(150, 166, 192, 1))),
                    onPressed: add,
                    child: const SizedBox(
                        height: 34,
                        width: 345,
                        child: Center(
                            child: Text(
                          'Создать',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'comfortaa'),
                        ))),
                  ),
                ),
            ]),
          );
        });
  }
}
