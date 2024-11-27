import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cart_provider.dart';

class ProductDetailProvider extends ChangeNotifier {
  int _quantity = 1;
  final int _berryPrice = 500;

  int get quantity => _quantity;
  int get totalPrice => _quantity * _berryPrice;

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/berries.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Berries',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<ProductDetailProvider>(
                builder: (context, provider, child) {
                  return Text(
                    'RWF ${provider.totalPrice}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Fresh, handpicked berries from local farms. Perfect for snacking, baking, or adding to your favorite smoothie.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Consumer<ProductDetailProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: provider.decreaseQuantity,
                        color: Colors.green,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '${provider.quantity}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: provider.increaseQuantity,
                        color: Colors.green,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer<ProductDetailProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: () {
                      // Add to cart using the centralized CartProvider
                      final cartProvider = context.read<CartProvider>();
                      cartProvider.addItem(
                        CartItem(
                          name: 'Berries',
                          description: 'Fresh, handpicked berries',
                          quantity: provider.quantity,
                          price: provider._berryPrice.toDouble(),
                          image: 'assets/berries.jpg',
                        ),
                      );
                      
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      
                      // Navigate to cart
                      Navigator.pushNamed(context, '/cart');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B8E3D),
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
      ),
    );
  }
}