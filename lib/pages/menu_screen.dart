import 'package:flutter/material.dart';
import 'package:mpit/data/colors.dart';
import 'package:mpit/data/lists.dart';
import 'package:mpit/var/var.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menu[index]['name']!, style: TextStyle(fontFamily: 'comfortaa', fontSize: 25, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text('Завтрак:', style: TextStyle(fontFamily: 'comfortaa', fontSize: 20, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text(menu[index]['breakfast']!, style: TextStyle(fontFamily: 'comfortaa', fontSize: 15, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text('Обед:', style: TextStyle(fontFamily: 'comfortaa', fontSize: 20, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text(menu[index]['lanch']!, style: TextStyle(fontFamily: 'comfortaa', fontSize: 15, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text('Полдник:', style: TextStyle(fontFamily: 'comfortaa', fontSize: 20, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text(menu[index]['lanch2']!, style: TextStyle(fontFamily: 'comfortaa', fontSize: 15, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text('Ужин:', style: TextStyle(fontFamily: 'comfortaa', fontSize: 20, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
                Text(menu[index]['dinner']!, style: TextStyle(fontFamily: 'comfortaa', fontSize: 15, color: (darkMode) ? textColor : Color.fromRGBO(26, 31, 41, 1)),),
                SizedBox(height: 5,),
              ],
            ),
          );
        },
      ),
    );
  }
}