import 'package:flutter/material.dart';
import 'account_state.dart';

@immutable
class AppState {
  final AccountState account;

  const AppState(this.account);
}
