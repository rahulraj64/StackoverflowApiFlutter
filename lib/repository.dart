import 'dart:async';
import 'dart:convert';

import 'package:flutter_stack_overflow_api/user.dart';
import 'package:http/http.dart' as http;

class Repository {

  static Future<List<User>> getStackOverflowUsers() async {
    String url =
        "https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print("Response --> $responseBody");
      var parsedMap = json.decode(responseBody);
      List<User> users = _parseUsersFromJsonMap(parsedMap);
      return users;
    } else {
      print("Server Error");
      return null;
    }
  }

  static List<User> _parseUsersFromJsonMap(Map<String, dynamic> jsonMap) {
    List<User> users = [];
    List items = jsonMap["items"];
    for (int i = 0; i < items.length; i++) {
      String name = items[i]["display_name"];
      String profileImage = items[i]["profile_image"];
      int reputation = items[i]["reputation"];
      int gold = items[i]["badge_counts"]["gold"];
      User user = User(
          name: name,
          profilePicUrl: profileImage,
          reputation: reputation,
          gold: gold);
      users.add(user);
    }
    return users;
  }
}