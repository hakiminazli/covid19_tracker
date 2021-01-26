import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/Screens/ManageProfile/ManageProfile.dart';
import 'package:http/http.dart'
as http; // add the http plugin in pubspec.yaml file.
import 'package:covid19_tracker/User.dart';

class ServicesMP {
  static const ROOT = 'https://covid19trackerdb.000webhostapp.com//userInfo.php';
  //static const ROOT = '';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _UPDATE_NAME_ACTION = 'UPDATE_NAME';
  static const _UPDATE_EMAIL_ACTION = 'UPDATE_EMAIL';
  static const _UPDATE_PASSWORD_ACTION = 'UPDATE_PASSWORD';
  static const _UPDATE_PHONENO_ACTION = 'UPDATE_PHONENO';

  // ignore: non_constant_identifier_names
  static Future<List<User>> getUser(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['email'] = email;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        print('getUser Response: ${response.body}');
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<String> updateName(String email, String name) async {
    try {
      if (name.isNotEmpty){
        var map = Map<String, dynamic>();
        map['action'] = _UPDATE_NAME_ACTION;
        map['email'] = email;
        map['name'] = name;
        final response = await http.post(ROOT, body: map);
        print('updateName Response: ${response.body}');
        if (200 == response.statusCode) {
          return response.body;
        } else {
          return "error";
        }
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<String> updateEmail(String email, String newEmail) async {
    try {
      if(newEmail.isNotEmpty) {
        var map = Map<String, dynamic>();
        map['action'] = _UPDATE_EMAIL_ACTION;
        map['email'] = email;
        map['newEmail'] = newEmail;
        final response = await http.post(ROOT, body: map);
        print('updateEmail Response: ${response.body}');
        if (200 == response.statusCode) {
          return response.body;
        } else {
          return "error";
        }
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<String> updatePassword(String email, String current, String newPassword) async {
    try {
      if(newPassword.isNotEmpty) {
        var map = Map<String, dynamic>();
        map['action'] = _UPDATE_PASSWORD_ACTION;
        map['email'] = email;
        map['current'] = current;
        map['newPassword'] = newPassword;
        final response = await http.post(ROOT, body: map);
        print('updatePassword Response: ${response.body}');
        if (200 == response.statusCode) {
          return response.body;
        } else {
          return "error";
        }
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  static Future<String> updatePhone(String email, String phoneNo) async {
    try {
      if (phoneNo.isNotEmpty){
        var map = Map<String, dynamic>();
        map['action'] = _UPDATE_PHONENO_ACTION;
        map['email'] = email;
        map['phoneNo'] = phoneNo;
        final response = await http.post(ROOT, body: map);
        print('updatePhoneNo Response: ${response.body}');
        if (200 == response.statusCode) {
          return response.body;
        } else {
          return "error";
        }
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

}

