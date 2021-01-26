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
import 'package:covid19_tracker/screens/checkup.dart';
import 'package:covid19_tracker/screens/maps.dart';
import 'package:covid19_tracker/pages/newsListPage.dart';
import 'package:covid19_tracker/viewmodels/newsArticlesListViewModel.dart';
import 'package:covid19_tracker/Screens/Login/components/body.dart';
import 'package:covid19_tracker/User.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: ProfileHeader(),
          ),

          Expanded(
            flex: 3,
            child: ControlCenter(),
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

class ProfileHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingValue),
      child: Center(
        child: ListTile(
          title: Text(
            'Welcome!',
            style: TextStyle(color: Colors.grey),
          ),
          subtitle: Text(
            profileName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 31),
          ),
          trailing: ProfileImage(
            imageLocation: 'assets/images/default.png',
          ),
        ),
      ),
    );
  }
}

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


// CONTROL CENTER (BIG BLUE BUTTON)

class ControlCenter extends StatelessWidget {
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
          color: Colors.lightBlueAccent[100],
          child: InkWell(
            splashColor: primaryColour.withAlpha(45),
            highlightColor: primaryColour.withAlpha(22),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  switch (index){
                    case 0:
                      return ChangeNotifierProvider(
                          builder: (_) => NewsArticleListViewModel(), child: NewsListPage());
                      break;
                    case 1:
                      return Location();
                      break;
                    case 2:
                      return CheckUp();
                      break;
                    case 3:
                      return MyLocation();
                      break;
                    default:
                  }
                  return NewPage();
                }),
              );
            },
            child: ListTile(
              leading: FaIcon(
                room.roomDataList[index].icon,
                color: Colors.black,
                size: 30,
              ),
              title: Text(

                room.roomDataList[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),

              ),
            ),
          ),
        );

      },
    );
  }
}

//USER CLASS
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('User page'),
      ),
    );
  }
}


//POWER PAGE CLASS
class PowerPage extends StatelessWidget {
  final Room room = Room();
 // final Room room = Room();
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
          color: Colors.white60,
          child: InkWell(
            splashColor: primaryColour.withAlpha(45),
            highlightColor: primaryColour.withAlpha(22),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NewPage();
                }),
              );
            },
            child: ListTile(
              leading: FaIcon(
                room.roomDataList[index].icon,
                color: primaryColour,
                size: 30,
              ),
              title: Text(

                  room.roomDataList[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  
              ),
            ),
          ),
        );
      },
    );
  }
}

//SETTING PAGE CLASS
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        'Get the source code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Name your own price @ gum.co/SxEWQ'),
                    ),
                  ),
                  tapCard(
                        () {
                      LaunchUrlUtil.launchUrl('https://twitter.com/hakimin_azli');
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
                      LaunchUrlUtil.launchUrl(
                          'https://gumroad.com/iqfareez');
                    },
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.codeBranch,
                          color: Color(0xFFEA4c89)),
                      title: Text(
                        'Inspiration',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                      Text('https://gumroad.com/iqfareez'),

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
