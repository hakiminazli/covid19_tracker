import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

class Reminder {
  final String time;
  final RepeatInterval repeat;
  final String name;

  const Reminder({
    @required this.time,
    @required this.repeat,
    @required this.name,
  });

  static Reminder fromJson(dynamic json) {
    return json != null
        ? new Reminder(
            time: json["time"],
            repeat: parseRepeatIntervalToValue(json["repeat"]),
            name: json["name"])
        : null;
  }

  dynamic toJson() {
    return {
      "time": time,
      "repeat": parseRepeatIntervalToString(repeat),
      "name": name,
    };
  }

  static String parseRepeatIntervalToString(RepeatInterval repeat) {
    switch (repeat) {
      case RepeatInterval.Daily:
        return "Daily";
      default:
        return "Daily";
    }
  }

  static RepeatInterval parseRepeatIntervalToValue(String repeat) {
    switch (repeat) {
      case "Daily":
        return RepeatInterval.Daily;
      default:
        return RepeatInterval.Weekly;
    }
  }
}
