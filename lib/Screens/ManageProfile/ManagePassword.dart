import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/ManageProfile/ServicesMP.dart';
import 'package:covid19_tracker/Screens/Login/components/background.dart';
import 'package:covid19_tracker/components/text_field_container.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/Screens/Login/components/body.dart';

final passwordController = TextEditingController();
final newPasswordController = TextEditingController();
final new2PasswordController = TextEditingController();

class ManagePassword extends StatelessWidget {
  const ManagePassword({
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
  bool visible = false ;

  update(){
    setState(() {
      visible = true ;
    });
    String one = passwordController.text;
    String two = newPasswordController.text;
    String three = new2PasswordController.text;

    if(one.isNotEmpty && two.isNotEmpty && three.isNotEmpty) {
      if (two == three){
        String e = sendEmail.getEmail();
        ServicesMP.updatePassword(e, one,  two).then((p) {
          print("Length ${p.length}");
          setState(() {
            visible = false;
          });
          if (p.length == 0) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text('Invalid Update: Existing Password Is Incorrect'),
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text('SUCCESSFUL!'),
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
        });
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Invalid Update: Double Check Your New Password'),
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
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Invalid Update: Please Fill In The Field'),
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
              "CHANGE PASSWORD",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            PasswordField(
              onChanged: (value) {},
            ),
             NewPasswordField(
               onChanged: (value) {},
             ),
             ReEnterPasswordField(
               onChanged: (value) {},
             ),
             RaisedButton(
                 onPressed: () {
                   update();
                 },
                 child: Text('CONFIRM',
                   style: TextStyle(color: Colors.black),)
             ),
            Visibility(
                visible: false,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator()
                )
            ),
            SizedBox(height: size.height * 0.03),
          ],
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
          hintText: "Existing Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class NewPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const NewPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: newPasswordController,
        autocorrect: true,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "New Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class ReEnterPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const ReEnterPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: new2PasswordController,
        autocorrect: true,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Re-enter New Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
