import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id = '', this.title = '', this.price = 0, this.quantity = 1});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = new Map<String, CartItem>();

  Map<String, CartItem> get items {
    return {...items};
  }

  void addItem(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (exists) => CartItem(
                id: exists.id,
                title: exists.title,
                price: exists.price,
                quantity: exists.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
  }
}