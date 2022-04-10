
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'images/Raster.png',
      nextScreen: MainScreen(),
    );
  }
}
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    );
  }
}
