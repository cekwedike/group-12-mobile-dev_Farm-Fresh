// cart_provider.dart
import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String description;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get shippingCost => 10.0;
  
  double get finalTotal => totalPrice + shippingCost;

  int get itemCount => _items.length;

  bool get isEmpty => _items.isEmpty;
  
  void addItem({
    required String name,
    required String description,
    required double price,
    required String image,
  }) {
    // Check if item already exists
    final existingItemIndex = _items.indexWhere((item) => item.name == name);
    
    if (existingItemIndex != -1) {
      // If item exists, increment quantity
      _items[existingItemIndex].quantity++;
    } else {
      // If item doesn't exist, add new item
      _items.add(CartItem(
        name: name,
        description: description,
        price: price,
        image: image,
      ));
    }
    notifyListeners();
  }
  
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
  
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length && quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  CartItem? getItem(int index) {
    if (index >= 0 && index < _items.length) {
      return _items[index];
    }
    return null;
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }
}