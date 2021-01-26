import 'package:flutter/material.dart';
import '../services/location_service.dart';

class WelcomeScreen extends StatelessWidget {
  LocationService locationService;
  WelcomeScreen({this.locationService});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final position = locationService.positions[index];
          return ListTile(
            leading: Icon(
              Icons.add_location,
              color: Colors.lightBlueAccent,
            ),
            title: Text('Location ${index + 1}'),
            subtitle: Text(
              'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
            ),
          );
        },
        itemCount: locationService.positions.length,
      ),
    );
  }
}
