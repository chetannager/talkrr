import 'package:flutter/material.dart';

@immutable
class GlobalState {
  dynamic channel;

  GlobalState({this.channel});

  initialState() {
    GlobalState(channel: null);
  }
}
