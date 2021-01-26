import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Login/login_screen.dart';
//import 'package:covid19_tracker/Screens/Signup/components/bodySignUp.dart';
import 'package:covid19_tracker/Screens/Signup/signup_screen.dart';
import '../components/background.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'package:covid19_tracker/constants.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "COVID-19 TRACKER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/photo6170027057271122818-removebg-preview.png",

              height: size.height * 0.4,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              color: kPrimaryColor,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "REGISTER",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
