import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Login/components/background.dart';
import 'package:covid19_tracker/Screens/Signup/signup_screen.dart';
import 'package:covid19_tracker/components/no_account.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/components/text_field_container.dart';
import 'package:covid19_tracker/constants.dart';

final emailController = TextEditingController();
final icController = TextEditingController();

class BodyFG extends StatelessWidget {
  const BodyFG({
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
    String ic = icController.text;
    String email = emailController.text;

    // API URL
    var url = 'https://covid19trackerdb.000webhostapp.com//forgotpassword.php';
    //var url = '';

    // Store all data with Param Name.
    var data = {'ic': ic, 'email': email,};

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }
    else{
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
              },
            ),
          ],
        );
      },
    );

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
              "RESET PASSWORD",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/photo6170027057271122818-removebg-preview.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            EmailField(
              hintText: "Your Email",
              onChanged: (value)  {
              },
            ),
            IcField(
              hintText: "Your IC",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SUBMIT",
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
