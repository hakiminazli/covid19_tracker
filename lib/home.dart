import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/Screens/main_page.dart';
import 'package:covid19_tracker/Screens/Welcome/welcome_screen.dart';




class Home extends StatefulWidget {

  Home();

  @override
  _HomeState createState() => _HomeState();
  static const routeName = '/home';
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    //combined into one code
    MainPage(),
    UserPage(),
    SettingPage(),
   // PowerPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),

      /*
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
    );
  }
}

//https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
