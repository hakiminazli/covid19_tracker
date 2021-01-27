import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Login/components/background.dart';
import 'package:covid19_tracker/Screens/ManageProfile/ManageProfile.dart';
import 'package:covid19_tracker/Screens/Welcome/welcome_screen.dart';
//import 'package:covid19_tracker/components/rounded_button.dart';
import 'package:covid19_tracker/Screens/Login/components/body.dart';
import 'package:covid19_tracker/User.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid19_tracker/Screens/main_page.dart';
import 'package:covid19_tracker/Screens/checkup.dart';

class HomepageReceiver extends StatelessWidget {
  HomepageReceiver({
    Key key,
  }) : super(key: key,);

   _getName()
   {
     List<User> u = userData.getUser();
     var name = u.map((u) => u.name);
     return name.toString();
   }

  _getEmail()
  {
    List<User> u = userData.getUser();
    var email = u.map((u) => u.email);
    return email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        centerTitle: true,
        //leading: IconButton(icon: Icon(Icons.menu),onPressed: (){}),

        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Logout Successful"),
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
            },
            icon: Icon(Icons.lock_open),
          )
        ],
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search),onPressed: (){}),
        //
        // ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(_getName()),
                accountEmail: new Text(_getEmail()),
            )
          ],
        ),
      ),

      body: TransferData(),
    );
  }
}

class TransferData extends StatefulWidget {
  TransferDataWidget createState() => TransferDataWidget();
}

class TransferDataWidget extends State {
  int _currentIndex = 0;
  final List<Widget> _children = [
  //combined into one code
      MainPage(),
      ManageProfile(),
      SettingPage(),
  // PowerPage(),
];
  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return Background(

      child: Scaffold(

        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          child: BottomNavigationBar(
            backgroundColor: primaryColour,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(color: accentColour, opacity: 1),
            unselectedIconTheme:
            IconThemeData(opacity: 0.4), //opacity ranged from 0 to 1
            iconSize: 18,

            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userFriends),
                label: 'User',
              ),
              /* BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bell),
              label: 'Menu',
            ),*/
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.cog),
                label: 'Setting',
              ),
            ],
            onTap: (itemIndex) {
              setState(() {
                _currentIndex = itemIndex;
              });
            },
          ),
        ),
        extendBody: true,
        body: SafeArea(bottom: false, child: _children[_currentIndex]),

            /*
            RoundedButton(
              text: "MANAGE PROFILE",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ManageProfile();
                  },
                );
              },
            ),


            RoundedButton(
              text: "LOGOUT",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Logout Successful"),
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
              },
            ),

             */


            //SizedBox(height: size.height * 0.01),
      //    ],
    //    ),
      ),
    );

  }
}