import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../actions/actions.dart';
import 'package:covid19_tracker/Screens/main_page.dart';
import '../models/index.dart';
import '../store/store.dart';
import '../utils/notificationHelper.dart';

import 'RemainderCustomItem.dart';
import 'RemainderItem.dart';

const String playMusic = 'Check body temp';
const String custom = 'PCR Test';

const remindersIcons = {
  playMusic: Icons.audiotrack,
  custom: Icons.image,
};

class ReminderAlertBuilder extends StatefulWidget {
  ReminderAlertBuilder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReminderAlertBuilderState createState() => _ReminderAlertBuilderState();
}

class _ReminderAlertBuilderState extends State<ReminderAlertBuilder> {
  bool playMusicReminder = false;
  bool customReminder = false;
  double margin = Platform.isIOS ? 10 : 5;

  TimeOfDay customNotificationTime;

  @override
  Widget build(BuildContext context) {
    _prepareState();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Manage reminders'),
            color: Colors.blue,
            onPressed: _showMaterialDialog,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
              backgroundColor: Colors.white,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 80,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                            padding: new EdgeInsets.only(bottom: margin),
                            child: Text(
                              'Remind me every day',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        ReminderItem(
                          onChanged: (value) {
                            setState(() {
                              playMusicReminder = value;
                            });
                            _configurePlayMusic(value);
                          },
                          checkBoxValue: playMusicReminder,
                          iconName: playMusic,
                        ),
                        Padding(
                            padding: new EdgeInsets.only(
                                bottom: margin, top: margin),
                            child: Text(
                              'Set Remainder',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        ReminderCustomItem(
                          checkBoxValue: customReminder,
                          iconName: custom,
                          onChanged: (value) {
                            setState(() {
                              customReminder = value;
                            });
                            _configureCustomReminder(value);
                          },
                          showTimeDialog: () {
                            _showTimeDialog(setState);
                          },
                        ),
                        Padding(
                          padding: new EdgeInsets.only(
                              top: margin * 2, bottom: margin),
                          child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  _showTimeDialog(StateSetter setState) async {
    TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    setState(() {
      customNotificationTime = selectedTime;
      customReminder = true;
    });

    _configureCustomReminder(true);
  }

  _prepareState() {
    List<Reminder> list = getStore().state.remindersState.reminders;

    list.forEach((item) {
      switch (item.name) {
        case playMusic:
          playMusicReminder = true;
          break;
        case custom:
          customReminder = true;
          break;
        default:
          return;
      }
    });
  }

  void _configurePlayMusic(bool value) {
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: playMusic,
          repeat: RepeatInterval.Daily));

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '0',
          playMusic, RepeatInterval.Daily);
    } else {
      turnOffNotificationById(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveReminderAction(playMusic));
    }
  }

  void _configureCustomReminder(bool value) {
    if (customNotificationTime != null) {
      if (value) {
        var now = new DateTime.now();
        var notificationTime = new DateTime(now.year, now.month, now.day,
            customNotificationTime.hour, customNotificationTime.minute);

        getStore().dispatch(SetReminderAction(
            time: notificationTime.toIso8601String(),
            name: custom,
            repeat: RepeatInterval.Daily));

        scheduleNotification(
            flutterLocalNotificationsPlugin, '4', custom, notificationTime);
      } else {
        getStore().dispatch(RemoveReminderAction(custom));
        turnOffNotificationById(flutterLocalNotificationsPlugin, 4);
      }
    }
  }
}
