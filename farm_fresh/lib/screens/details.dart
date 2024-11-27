import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cart_provider.dart';
import './explorescreen.dart';

class ProductDetailProvider extends ChangeNotifier {
  int _quantity = 1;

  int get quantity => _quantity;
  double get totalPrice => _quantity * 2500.0; // Base price for Fresh Strawberries

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  if (cartProvider.items.isEmpty) return const SizedBox();
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartProvider.items.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/berries.jpg',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fresh Strawberries',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<ExploreProvider>(
                        builder: (context, provider, child) {
                          return IconButton(
                            icon: Icon(
                              provider.isFavorite('Fresh Strawberries')
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xFF1B8E3D),
                            ),
                            onPressed: () {
                              provider.toggleFavorite('Fresh Strawberries');
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Berry Haven Farms',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const Text(
                        ' 4.8',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' (892 reviews)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<ProductDetailProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        'RWF ${provider.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B8E3D),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sweet & Juicy fresh strawberries handpicked from our local farm. Perfect for snacking, desserts, or adding to your favorite smoothie. Our strawberries are grown using sustainable farming practices to ensure the best quality and taste.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<ProductDetailProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: provider.decreaseQuantity,
                                  color: Colors.green,
                                ),
                                Text(
                                  '${provider.quantity}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: provider.increaseQuantity,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Available in stock',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Consumer2<ProductDetailProvider, CartProvider>(
                    builder: (context, detailProvider, cartProvider, child) {
                      return ElevatedButton(
                        onPressed: () {
                          cartProvider.addItem(
                            CartItem(
                              name: 'Fresh Strawberries',
                              description: 'Sweet & Juicy • Berry Haven Farms',
                              quantity: detailProvider.quantity,
                              price: 2500.0,
                              image: 'assets/berries.jpg',
                            ),
                          );
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.white),
                                  const SizedBox(width: 8),
                                  const Text('Added to cart'),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                    child: const Text(
                                      'VIEW CART',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B8E3D),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}