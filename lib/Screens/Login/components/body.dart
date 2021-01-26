import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Homepage/homepageReceiver.dart';
import 'package:covid19_tracker/User.dart';
import 'package:covid19_tracker/Screens/Login/components/Services.dart';
import 'package:covid19_tracker/Screens/Login/components/background.dart';
import 'package:covid19_tracker/Screens/Login/components/forgetPassword.dart';
import 'package:covid19_tracker/Screens/Signup/signup_screen.dart';
import 'package:covid19_tracker/components/forget_password.dart';
import 'package:covid19_tracker/components/no_account.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'package:covid19_tracker/components/text_field_container.dart';
import 'package:covid19_tracker/constants.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

// ignore: camel_case_types
class sendEmail {
  // ignore: non_constant_identifier_names
  static String emel = '';

  static setEmail (String e) {
    print(e);
     emel = e;
  }

  static getEmail () {
    return emel;
  }
}

// ignore: camel_case_types
class userData {
  // ignore: non_constant_identifier_names
  static List<User> _user;

  static setUser (List<User> u) {
    print(u);
    _user = u;
  }

  static getUser () {
    return _user;
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: TransferData(),
    );
  }
}

class TransferData extends StatefulWidget {
  TransferDataWidget createState() => TransferDataWidget();
}

class TransferDataWidget extends State {
  List<User> _user = [];

  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  Future webCall() async{

    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    sendEmail.setEmail(email);

    Services.getUser(email, password).then((user) {
      setState(() {
        _user = user;
      });
      print("Length ${user.length}");
      setState(() {
        visible = false;
      });
      if (user.length == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Invalid Login'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      else {
        _user.map((user) => user.email);
        userData.setUser(_user);
        String user = email;
        if(user == email)
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return HomepageReceiver();
            },
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/photo6170027057271122818-removebg-preview.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            EmailField(
              hintText: "Email Address",
              onChanged: (value)  {
              },
            ),
            PasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                webCall();
              },
            ),
            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator()
                )
            ),
            SizedBox(height: size.height * 0.03),
            NoAccount(
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
            ForgetPassword(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BodyFG();
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

class EmailField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const EmailField({
    Key key,
    this.hintText,
    this.icon = Icons.mail,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: emailController,
        autocorrect: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: passwordController,
        autocorrect: true,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
