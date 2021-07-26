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
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((_, value) {
      total += value.price * value.quantity;
    });
    return total;
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

    notifyListeners();
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (_items.containsKey(prodId)) {
      return;
    }

    if (_items[prodId]!.quantity > 1) {
      _items.update(
          prodId,
          (exists) => CartItem(
              id: exists.id,
              title: exists.title,
              price: exists.price,
              quantity: exists.quantity - 1));
    } else {
      _items.remove(prodId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
