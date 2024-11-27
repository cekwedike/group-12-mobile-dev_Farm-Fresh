import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cart_provider.dart';

class ExploreProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void toggleFavorite(String productName) {
    if (_favorites.contains(productName)) {
      _favorites.remove(productName);
    } else {
      _favorites.add(productName);
    }
    notifyListeners();
  }

  bool isFavorite(String productName) {
    return _favorites.contains(productName);
  }
}

class FarmFreshScreen extends StatelessWidget {
  const FarmFreshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Farm Fresh',
            style: TextStyle(
              color: Color(0xFF1B8E3D),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFF1B8E3D),
                  ),
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
            Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: Color(0xFF1B8E3D),
                  size: 22,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.6,
              children: const [
                ProductCard(
                  name: 'Fresh Strawberries',
                  price: 2500,
                  description: 'Sweet & Juicy',
                  rating: 4.8,
                  reviews: 892,
                  vendor: 'Berry Haven Farms'
                ),
                ProductCard(
                  name: 'Organic Raspberries',
                  price: 3200,
                  description: 'Premium Quality',
                  rating: 4.5,
                  reviews: 672,
                  vendor: 'Nature\'s Best'
                ),
                ProductCard(
                  name: 'Wild Cranberries',
                  price: 4500,
                  description: 'Forest Picked',
                  rating: 4.7,
                  reviews: 445,
                  vendor: 'Forest Delights'
                ),
                ProductCard(
                  name: 'Red Currants',
                  price: 1800,
                  description: 'Garden Fresh',
                  rating: 4.6,
                  reviews: 523,
                  vendor: 'Garden Fresh Co.'
                ),
                ProductCard(
                  name: 'Goji Berries',
                  price: 8500,
                  description: 'Premium Dried',
                  rating: 4.9,
                  reviews: 328,
                  vendor: 'Superfood Hub'
                ),
                ProductCard(
                  name: 'Mixed Red Berries',
                  price: 5200,
                  description: 'Assorted Selection',
                  rating: 4.4,
                  reviews: 756,
                  vendor: 'Berry Mix Masters'
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1B8E3D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String description;
  final double rating;
  final int reviews;
  final String vendor;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/product_details',
                        arguments: {
                          'name': name,
                          'price': price,
                          'description': description,
                          'rating': rating,
                          'reviews': reviews,
                          'vendor': vendor,
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/berries.jpg',
                        height: constraints.maxHeight * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer<ExploreProvider>(
                      builder: (context, provider, child) {
                        return GestureDetector(
                          onTap: () {
                            provider.toggleFavorite(name);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              provider.isFavorite(name)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xFF1B8E3D),
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vendor,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'RWF $price',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Text(
                          ' $rating',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' ($reviews)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return ElevatedButton(
                            onPressed: () {
                              cartProvider.addItem(
                                CartItem(
                                  name: name,
                                  description: '$description • $vendor',
                                  quantity: 1,
                                  price: price.toDouble(),
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
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}