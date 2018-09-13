import 'dart:async';
import 'dart:convert';

import 'package:flutter_stack_overflow_api/user.dart';
import 'package:http/http.dart' as http;

class Repository {

  Future<List<User>> getStackOverflowUsers() async {
    String url =
        "https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print("Response --> $responseBody");
      var parsedMap = json.decode(responseBody);
      List<User> users = parseUsersFromJsonMap(parsedMap);
      return users;
    } else {
      print("Server Error");
      return null;
    }
  }
}