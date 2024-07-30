// ignore_for_file: unused_local_variable

import 'package:ballbird/Padges/Widgets/Ball.dart';
import 'package:ballbird/Padges/Widgets/Clouds.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  const Game({super.key});
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    // system variabuls
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Random randomNumber = Random();

    // game variabuls
    int score = 0;

    // homes variabuls
    double homet = 300 + (randomNumber.nextDouble() * 100);
    double homer = randomNumber.nextDouble() * (screenWidth - 100);

    // player variabuls
    int playerHealth = 100;
    double playerx = 10;
    double playery = 10;

    // functions

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          // clouds
          Clouds(),
          // homes
          Positioned(
            top: homet,
            right: homer,
            width: 100,
            height: 500,
            child: Stack(
              children: [
                Container(
                  color: Color(0xFF5F2E2E),
                ),
              ],
            ),
          ),
          // Ball
          Ball(),
          // user info
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              'هوب هوب ياكوره',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              'الدرجه $score',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}



