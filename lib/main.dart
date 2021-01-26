import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Welcome/welcome_screen.dart';
import 'package:covid19_tracker/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new WelcomeScreen(),
      theme: new ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.blue[100],
      ),
    );
  }

}
