import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomData {
  String title;
  IconData icon;

  RoomData({this.icon, this.title});
}

class Room {
  List<RoomData> roomDataList = [
    RoomData(
        icon: FontAwesomeIcons.newspaper,
        title: 'COVID-19 News'),
    RoomData(
        icon: FontAwesomeIcons.plane,
        title: 'Travel History'),
    RoomData(
        icon: FontAwesomeIcons.stethoscope,
        title: 'Check-Up'),
    RoomData(
        icon: FontAwesomeIcons.locationArrow,
        title: 'My Location')

    //add more RoomData() if you want to. It should automoatically resize according to your time
  ];
}
