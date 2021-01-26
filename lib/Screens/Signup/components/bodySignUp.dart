import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Login/components/background.dart';
import 'package:covid19_tracker/Screens/Login/login_screen.dart';
import 'package:covid19_tracker/Screens/Welcome/welcome_screen.dart';
import 'package:covid19_tracker/components/already_have_account.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/components/text_field_container.dart';
import 'package:covid19_tracker/constants.dart';

// Getting value from TextField widget.
final nameController = TextEditingController();
final icController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final phoneNoController = TextEditingController();
final dateOfBirthController = TextEditingController();
final genderController = TextEditingController();
final addressController = TextEditingController();



class bodySignUp extends StatelessWidget {
  const bodySignUp({
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

  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  Future webCall() async{

    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String name = nameController.text;
    String ic = icController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phoneNo = phoneNoController.text;
   /* String dateOfBirth = dateOfBirthController.text;
    String gender = genderController.text;
    String zoneStatus = zoneStatusController.text;
*/
    // API URL

    if (name.isNotEmpty && ic.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      var url = 'https://covid19trackerdb.000webhostapp.com/submit_data.php';

      // Store all data with Param Name.
      var data = {
        'name': name,
        'ic': ic,
        'email': email,
        'password': password,
        'phoneNo' : phoneNo,

      };

      // Starting Web Call with data.
      var response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        setState(() {
          visible = false;
        });
      }
      else {
        setState(() {
          visible = false;
        });
      }

      // Showing Alert Dialog with Response JSON.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          WelcomeScreen(),
                    ),
                  );
                },

              ),
            ],
          );
        },
      );
      //return WelcomeScreen();
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Form cannot be empty! Please fill completely"),
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
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/photo6170027057271122818-removebg-preview.png",
              height: size.height * 0.15,
            ),
            SizedBox(height: size.height * 0.01),
            NameField(
              hintText: "Full Name",
              onChanged: (value)  {
              },
            ),
            IcField(
              hintText: "IC Number",
              onChanged: (value)  {
              },
            ),
            EmailField(
              hintText: "Email Address",
              onChanged: (value)  {
              },
            ),
            PasswordField(
              onChanged: (value) {},
            ),
            PhoneNoField(
              hintText: "Phone No.",
              onChanged: (value)  {
              },
            ),

            RoundedButton(
              text: "SIGN UP",
              press: () {
                webCall();
                //return WelcomeScreen();
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
            AlreadyHaveAccount(
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
          ],
        ),
      ),
    );

  }
}

class NameField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const NameField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: nameController,
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

class IcField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const IcField({
    Key key,
    this.hintText,
    this.icon = Icons.card_membership,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: icController,
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

class PhoneNoField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const PhoneNoField({
    Key key,
    this.hintText,
    this.icon = Icons.phone_android,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: phoneNoController,
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


