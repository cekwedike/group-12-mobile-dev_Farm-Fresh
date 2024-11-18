import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Details with Provider',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProductDetailScreen(),
    );
  }
}

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/berries.png',
                  height: 100,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Berries',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Consumer<ProductDetailProvider>(
                builder: (context, provider, child) {
                  return Text(
                    'RWF ${provider.totalPrice}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Consumer<ProductDetailProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: provider.decreaseQuantity,
                      ),
                      Text(
                        '${provider.quantity}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: provider.increaseQuantity,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart_screen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B8E3D),
                  minimumSize: const Size(double.infinity, 30),
                ),
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}