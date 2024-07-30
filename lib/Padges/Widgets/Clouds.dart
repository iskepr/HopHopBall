import 'dart:math';
import 'package:flutter/material.dart';

class Clouds extends StatelessWidget {
  const Clouds({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Generate non-overlapping clouds
    List<Widget> clouds =
        generateNonOverlappingClouds(screenWidth, screenHeight);

    return Stack(
      children: clouds,
    );
  }

  List<Widget> generateNonOverlappingClouds(
      double screenWidth, double screenHeight) {
    Random randomNumber = Random();
    List<Widget> cloudWidgets = [];
    List<Rect> cloudRectangles = [];

    for (int i = 0; i < 3; i++) {
      double cloudWidth = 200.0;
      double cloudHeight = 150.0;

      double top;
      double right;
      Rect cloudRect;
      bool isOverlapping;

      do {
        top = randomNumber.nextDouble() * (screenHeight - cloudHeight);
        right = randomNumber.nextDouble() * (screenWidth - cloudWidth);
        cloudRect = Rect.fromLTWH(
            screenWidth - right - cloudWidth, top, cloudWidth, cloudHeight);

        isOverlapping = cloudRectangles
            .any((existingRect) => cloudRect.overlaps(existingRect));
      } while (isOverlapping);

      cloudRectangles.add(cloudRect);

      // Create cloud widget
      Positioned cloud = Positioned(
        width: cloudWidth,
        height: cloudHeight,
        top: top,
        right: right,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 70,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 100,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 90,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

      cloudWidgets.add(cloud);
    }

    return cloudWidgets;
  }
}
