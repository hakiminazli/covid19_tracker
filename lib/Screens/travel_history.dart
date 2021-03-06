import 'package:flutter/material.dart';
import '../Screens/history.dart';
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  final LocationService locationService;
  Location({this.locationService});
  // location
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var locationMessage = '';
  String latitude;
  String longitude;

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    widget.locationService.add(position);

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
  }

  // function for opening it in google maps

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 45.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Get User Location",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              locationMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 05.0,
            ),

            // button for taking the location
            FlatButton(
              color: Colors.white,
              onPressed: () {
                getCurrentLocation();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(
                        locationService: widget.locationService,
                      )),
                );
              },
              child: Text("Get User Location"),
            ),

            FlatButton(
              color: Colors.white,
              onPressed: () {
                googleMap();
              },
              child: Text("Open GoogleMap"),
            ),
          ],
        ),
      ),
    );
  }
}
