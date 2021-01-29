import 'dart:io';
import 'package:covid19_tracker/Screens/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/database/room_data.dart';
import 'package:covid19_tracker/screens/new%20file.dart';
import 'package:covid19_tracker/Utils/launch_url_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid19_tracker/screens/travel_history.dart';
import 'package:covid19_tracker/Screens/checkUpReminder.dart';
import 'package:covid19_tracker/pages/newsListPage.dart';
import 'package:covid19_tracker/viewmodels/newsArticlesListViewModel.dart';
import 'package:covid19_tracker/services/location_service.dart';
import 'package:covid19_tracker/Screens/Login/components/body.dart';
import '../User.dart';
import 'ManageProfile/ServicesMP.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:covid19_tracker/CheckUp/store/AppState.dart';
import 'package:covid19_tracker/CheckUp/utils/notificationHelper.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:covid19_tracker/CheckUp/store/store.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:covid19_tracker/CheckUp/builder/NotificationSwitchBuilder.dart';
import 'package:covid19_tracker/CheckUp/builder/RemainderAlertBuilder.dart';
import 'package:covid19_tracker/CheckUp/builder/RemainderListViewBuilder.dart';
import 'package:covid19_tracker/CheckUp/models/index.dart';

final df = new DateFormat('dd-MM-yyyy hh:mm a');

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
Store<AppState> store;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LocationService locationService = LocationService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(

                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[900], Colors.greenAccent]
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: ProfileHeader(),
          ),
          Expanded(
            flex: 3,
            child: ControlCenter(
              locationService: locationService,
            ),
          ),
          Container(
            color: accentColour,
            height: MediaQuery.of(context).size.height / 16,
          )
        ],
      ),
    );
  }
}

//TOP PROFILE HEADER

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  List<User> _userInfo = [];

  @override
  Widget build(BuildContext context) {
    _getUser() {
      String email = sendEmail.getEmail();
      ServicesMP.getUser(email).then((user) {
        setState(() {
          _userInfo = user;
        });
        print("Length ${user.length}");
      });
    }

    _getUser();
    return Padding(
      padding: const EdgeInsets.all(paddingValue),
      child: Center(
        child: ListTile(
          title: Text(
            'Welcome!',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            _userInfo.length > 0 ? _userInfo.first.name : 'User',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 31),
          ),
          /*     trailing: ProfileImage(
            imageLocation: 'assets/images/default.png',
          ),

      */
        ),
      ),
    );
  }
}
/*
class ProfileImage extends StatelessWidget {
  const ProfileImage({Key key, this.imageLocation}) : super(key: key);

  final String imageLocation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        imageLocation,
        fit: BoxFit.fill,
      ),
    );
  }
}

 */



class ControlCenter extends StatelessWidget {
  final LocationService locationService;
  ControlCenter({this.locationService});
  final Room room = Room();
  final double axisSpacing = 26;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(axisSpacing),
      itemCount: room.roomDataList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600
              ? 4
              : 2, //layour rendered quite differently on different screen sizes
          crossAxisSpacing: axisSpacing,
          mainAxisSpacing: axisSpacing),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.lightBlueAccent[200],
          child: InkWell(
            splashColor: primaryColour.withAlpha(45),
            highlightColor: primaryColour.withAlpha(22),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  switch (index) {
                    case 0:
                      return ChangeNotifierProvider(
                        //  create: (context) {},
                          builder: (_) => NewsArticleListViewModel(),
                          child: NewsListPage());
                      break;
                    case 1:
                      return History(
                        locationService: locationService,
                      );
                      break;
                    case 2:

                      Future<void> check() async {
                        WidgetsFlutterBinding.ensureInitialized();
                        await initStore();
                        store = getStore();
                        notificationAppLaunchDetails =
                        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
                        await initNotifications(flutterLocalNotificationsPlugin);
                        requestIOSPermissions(flutterLocalNotificationsPlugin);

                        runApp(LaunchingApp(store));
                      }
                      check();

                      break;
                    case 3:
                      return Location(
                        locationService: locationService,
                      );
                      break;
                    default:
                  }
                  return LaunchingApp(store);
                }),
              );
            },
            child: ListTile(
              leading: FaIcon(
                room.roomDataList[index].icon,
                color: Colors.black,
                size: 35,
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  room.roomDataList[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            
          ),
        );
      },
    );
  }
}

class LaunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LaunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'REMINDERS',
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Checkup Remainder'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ReminderAlertBuilder()),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: NotificationSwitchBuilder()),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Reminders list",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: SizedBox(
                            child: StoreConnector<AppState, List<Reminder>>(
                                converter: (store) =>
                                store.state.remindersState.reminders,
                                builder: (context, reminders) {
                                  return RemindersList(reminders: reminders);
                                }),
                            height: Platform.isAndroid ? 420 : 550,
                          ))),
                ],
              ),
            ),
          )),
      store: store,
    );
  }
}

//SETTING PAGE CLASS
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(

              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red]
          )
      ),
      padding: EdgeInsets.all(12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  tapCard(
                        () {
                      LaunchUrlUtil.launchUrl('https://gum.co/SxEWQ');
                    },
                    ListTile(
                      leading:
                      FaIcon(FontAwesomeIcons.code, color: Colors.black),
                      title: Text(
                        'Reference',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Gumroad @ gum.co/SxEWQ'),
                    ),
                  ),
                  tapCard(
                        () {
                      LaunchUrlUtil.launchUrl(
                          'https://twitter.com/hakimin_azli');
                    },
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xFF1DA1F2),
                      ),
                      title: Text(
                        'Follow me',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('https://twitter.com/hakimin_azli'),
                    ),
                  ),
                  tapCard(
                        () {
                      LaunchUrlUtil.launchUrl('https://gumroad.com/iqfareez');
                    },
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.codeBranch,
                          color: Color(0xFFEA4c89)),
                      title: Text(
                        'Inspiration',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('https://gumroad.com/iqfareez'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/undraw_source_code_xx2e.svg'),
              ),
            )
          ]),
    );
  }
}

Widget tapCard(Function _onTap, Widget _child) {
  return Card(
    child: InkWell(
      splashColor: accentColour.withAlpha(30),
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: _child,
      ),
    ),
  );
}


