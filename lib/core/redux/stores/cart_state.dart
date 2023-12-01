import 'package:flutter/material.dart';

@immutable
class CartState {
  Map<String, dynamic> cartMeta = {};
  List<dynamic> cartItems = [];
  List<dynamic> addresses = [];
}
