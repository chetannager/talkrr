import 'dart:convert';
import 'package:talkrr/utils/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class api {
  Future<dynamic> authentication(username, password) async {
    final Map<String, dynamic> requestData = {
      "username": username,
      "password": password
    };
    final http.Response response = await http.post(
      Uri.parse("${Endpoints.baseAPIUrl}authentication"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(requestData),
    );
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }

  Future<dynamic> register(username, fullname, password) async {
    final Map<String, dynamic> requestData = {
      "username": username,
      "fullname": fullname,
      "password": password
    };
    final http.Response response = await http.post(
      Uri.parse("${Endpoints.baseAPIUrl}register"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(requestData),
    );
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }
}
