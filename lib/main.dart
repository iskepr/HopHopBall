// ignore_for_file: unused_import
import 'package:ballbird/Padges/Game.dart';
import 'package:ballbird/Padges/MainMenu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'هوب هوب ياكوره',
      theme: ThemeData(
        textTheme: TextTheme(labelMedium: TextStyle(color: Colors.white, fontSize: 14)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'IBM',
      ),
      routes: {
        '/': (context) => Game(),
        // '/': (context) => MainMenu(),
        '/العبه': (context) => Game(),
        '/الاعدادات': (context) => Game(),
      },
    );
  }
}
