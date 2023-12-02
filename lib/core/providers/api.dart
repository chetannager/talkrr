import 'dart:convert';
import 'package:talkrr/utils/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const Duration requestTimeout = Duration(seconds: 10);

class api {
  // Login :: Authentication APIs
  Future<dynamic> authentication(username, password) async {
    final Map<String, dynamic> requestData = {
      "username": username,
      "password": password
    };
    if (kDebugMode) {
      print("requestData:${json.encode(requestData)}");
    }
    final http.Response response = await http
        .post(
          Uri.parse("${Endpoints.baseAPIUrl}authentication"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(requestData),
        )
        .timeout(requestTimeout);
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }

  // Register :: Register APIs
  Future<dynamic> register(username, fullname, password) async {
    final Map<String, dynamic> requestData = {
      "emailAddress": username,
      "fullName": fullname,
      "password": password
    };
    if (kDebugMode) {
      print("requestData:${json.encode(requestData)}");
    }
    final http.Response response = await http
        .post(
          Uri.parse("${Endpoints.baseAPIUrl}register"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode(requestData),
        )
        .timeout(requestTimeout);
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }

  // New Call :: Get All Users APIs
  Future<dynamic> getAllUsers(authToken) async {
    final http.Response response = await http.get(
      Uri.parse("${Endpoints.baseAPIUrl}users"),
      headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      },
    ).timeout(requestTimeout);
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }

  // Orders :: Get All Orders APIs
  Future<dynamic> getAllCalls(authToken) async {
    final http.Response response = await http.get(
      Uri.parse("${Endpoints.baseAPIUrl}"),
      headers: {
        "Authorization": "Bearer $authToken",
        "Accept": "application/json"
      },
    ).timeout(requestTimeout);
    if (kDebugMode) {
      print("statusCode:${response.statusCode}");
    }
    return response;
  }
}
