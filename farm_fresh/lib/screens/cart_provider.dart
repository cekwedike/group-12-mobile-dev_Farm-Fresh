import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(CartItem item) {
    // Check if item already exists
    final existingIndex = _items.indexWhere((i) => i.name == item.name);
    if (existingIndex >= 0) {
      // If item exists, increment quantity
      _items[existingIndex] = CartItem(
        name: item.name,
        description: item.description,
        quantity: _items[existingIndex].quantity + item.quantity,
        price: item.price,
        image: item.image,
      );
    } else {
      // If item doesn't exist, add it
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      final item = _items[index];
      _items[index] = CartItem(
        name: item.name,
        description: item.description,
        quantity: newQuantity,
        price: item.price,
        image: item.image,
      );
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final String name;
  final String description;
  final int quantity;
  final double price;
  final String image;

  CartItem({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.image,
  });
}