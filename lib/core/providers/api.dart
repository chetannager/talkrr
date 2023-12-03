import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // Users :: Get All Users APIs
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

  // Calls :: Get All Recent Calls APIs
  Future<dynamic> getAllCalls(authToken) async {
    final http.Response response = await http.get(
      Uri.parse("${Endpoints.baseAPIUrl}calls"),
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

  // Call :: Create Call APIs
  Future<dynamic> createCall(authToken, receiverId, receiverFullName) async {
    final Map<String, dynamic> requestData = {
      "receiverId": receiverId,
      "receiverFullName": receiverFullName
    };
    if (kDebugMode) {
      print("requestData:${json.encode(requestData)}");
    }
    final http.Response response = await http
        .post(
          Uri.parse("${Endpoints.baseAPIUrl}call"),
          headers: {
            "Authorization": "Bearer $authToken",
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

  // Login :: Subscribe Device to Account APIs
  Future<dynamic> subscribeDeviceToAccount(authToken) async {
    FirebaseMessaging.instance.getToken().then((value) async {
      final Map<String, dynamic> requestData = {
        'registrationToken': value,
      };
      if (kDebugMode) {
        print("requestData:${json.encode(requestData)}");
      }
      final http.Response response = await http.post(
          Uri.parse("${Endpoints.baseAPIUrl}subscribeDeviceToAccount"),
          headers: {
            "Authorization": "Bearer $authToken",
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: json.encode(requestData));
      if (kDebugMode) {
        print("statusCode:${response.statusCode}");
      }
      return response;
    });
  }

  // Login :: UnSubscribe Device to Account APIs
  Future<dynamic> unsubscribeDeviceToAccount(authToken) async {
    FirebaseMessaging.instance.getToken().then((value) async {
      final Map<String, dynamic> requestData = {
        'registrationToken': value,
      };
      if (kDebugMode) {
        print("requestData:${json.encode(requestData)}");
      }
      final http.Response response = await http.post(
          Uri.parse("${Endpoints.baseAPIUrl}unsubscribeDeviceToAccount"),
          headers: {
            "Authorization": "Bearer $authToken",
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: json.encode(requestData));
      if (kDebugMode) {
        print("statusCode:${response.statusCode}");
      }
      return response;
    });
  }
}
