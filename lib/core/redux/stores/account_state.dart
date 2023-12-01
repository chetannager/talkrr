import 'package:flutter/material.dart';

@immutable
class AccountState {
  bool isLoggedIn = false;
  String AUTH_TOKEN = "";
  Map<String, dynamic> userDetails = {};

  AccountState({required this.isLoggedIn, required this.AUTH_TOKEN, required this.userDetails});

  initialState() {
    AccountState(isLoggedIn: false,AUTH_TOKEN: "",userDetails: {});
  }
}
