import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/Homepage/homepageReceiver.dart';
import 'package:covid19_tracker/Screens/Login/components/body.dart';
import 'package:covid19_tracker/Screens/Login/login_screen.dart';
import 'package:covid19_tracker/Screens/ManageProfile/ManagePassword.dart';
import 'package:covid19_tracker/Screens/ManageProfile/ServicesMP.dart';
import 'package:covid19_tracker/User.dart';
import 'package:covid19_tracker/components/rounded_button.dart';
import 'package:covid19_tracker/constants.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final phoneNoController = TextEditingController();

// ignore: camel_case_types
class ManageProfile extends StatelessWidget {
  const ManageProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      body: DataTableUser(),
    );
  }
}

class DataTableUser extends StatefulWidget {
  DataTableUser() : super();
  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableUser> {
  List<User> _userInfo;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _userInfo = [];
    _scaffoldKey = GlobalKey();
    _getUser();
  }

  _getUser() {
    String email = sendEmail.getEmail();
    ServicesMP.getUser(email).then((user) {
      setState(() {
        _userInfo = user;
      });
      print("Length ${user.length}");
    });
  }

  _updateName() {
    String email = sendEmail.getEmail();
    String name = nameController.text;
    ServicesMP.updateName(email, name).then((result) {
      if ('success' == result) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ManageProfile();
          },
        );
      }
    });
  }


  _updateEmail() {
    String email = sendEmail.getEmail();
    String newEmail = emailController.text;
    ServicesMP.updateEmail(email, newEmail).then((result) {
      if ('success' == result) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoginScreen();
          },
        );
      }
    });
  }

  _updatePhoneNo(){
    String email = sendEmail.getEmail();
    String phoneNo = phoneNoController.text;
    ServicesMP.updateName(email, phoneNo).then((result) {
      if ('success' == result) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ManageProfile();
          },
        );
      }
    });
  }

  SingleChildScrollView _dataName() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showBottomBorder: true,
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text(''))
          ],
          rows: _userInfo.map((user) => DataRow(cells: [
            DataCell(
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(user.name),
              )
            ),
            DataCell(IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  child: new AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new TextField(
                            autofocus: true,
                            decoration: new InputDecoration(
                                labelText: 'Full Name', hintText: ''),
                            controller: nameController,
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          child: const Text('CLOSE'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      new FlatButton(
                          child: const Text('OKAY'),
                          onPressed: () {
                            _updateName();
                          })
                    ],
                  ),
                );
              },
            ),),
            ]))
              .toList(),
      ),
    ));
  }

  SingleChildScrollView _dataID() {
    // Both Vertical and Horizontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('IC Number')),
            ],
            rows: _userInfo.map((user) => DataRow(cells: [
              DataCell(
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(user.IC),
                  )
              ),
            ]))
                .toList(),
          ),
        ));
  }

  SingleChildScrollView _dataEmail() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('Email')),
              DataColumn(label: Text(''))
            ],
            rows: _userInfo.map((user) => DataRow(cells: [
              DataCell(
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(user.email),
                  )
              ),
              DataCell(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    child: new AlertDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      content: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'New Email:', hintText: ''),
                              controller: emailController,
                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('CLOSE'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        new FlatButton(
                            child: const Text('OKAY'),
                            onPressed: () {
                              _updateEmail();
                            })
                      ],
                    ),
                  );
                },
              ),),
            ]))
                .toList(),
          ),
        ));
  }

  SingleChildScrollView _dataPassword() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('Password')),
              DataColumn(label: Text(''))
            ],
            rows: _userInfo.map((user) => DataRow(cells: [
              DataCell(
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text('Edit Password'),
                  )
              ),
              DataCell(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ManagePassword();
                    },
                  );
                },
              ),),
            ]))
                .toList(),
          ),
        ));
  }

  SingleChildScrollView _dataPhoneNo() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text(''))
            ],
            rows: _userInfo.map((user) => DataRow(cells: [
              DataCell(
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(user.phoneNo),
                  )
              ),
              DataCell(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    child: new AlertDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      content: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'New Phone Number', hintText: ''),
                              controller: phoneNoController,
                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('CLOSE'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        new FlatButton(
                            child: const Text('OKAY'),
                            onPressed: () {
                              _updatePhoneNo();
                            })
                      ],
                    ),
                  );
                },
              ),),
            ]))
                .toList(),
          ),
        ));
  }


  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
         title: Text('USER PROFILE'),

          backgroundColor: primaryColour,
          // actions: <Widget>[
          //   new IconButton(
          //     icon: new Icon(Icons.close),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          // ],
          //leading: new Container(),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[


              _dataName(),
              _dataID(),
              _dataEmail(),
              _dataPassword(),
              _dataPhoneNo(),
            ],
          ),
        )
    );
  }

}

