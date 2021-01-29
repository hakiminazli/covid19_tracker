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
      home: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/wp4779729-baby-blue-fur-wallpapers.jpg"),
                    fit: BoxFit.cover)
            ),
              child: new WelcomeScreen(),
          )
      ),
      theme: new ThemeData(
        primaryColor: primaryColour,
        scaffoldBackgroundColor: Colors.blue[100],
      ),
    );
  }

}
