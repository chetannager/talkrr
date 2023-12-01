import 'package:flutter/material.dart';

class AddToCartAction {
  int itemId;

  AddToCartAction(@required this.itemId);
}

class DeleteToCartAction {
  int itemId;

  DeleteToCartAction(@required this.itemId);
}

class CartSyncAction {
  Map<String, dynamic> cartMeta = {};
  List<dynamic> cartItems = [];
  List<dynamic> addresses = [];

  CartSyncAction(this.cartMeta, this.cartItems, this.addresses);
}

class CartAddressesSyncAction {
  List<dynamic> addresses = [];

  CartAddressesSyncAction(this.addresses);
}

class EmptyCartAction {
  EmptyCartAction();
}
