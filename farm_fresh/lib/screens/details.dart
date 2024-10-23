import 'package:flutter/material.dart';


class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedIndex = 0;  // For bottom navigation bar state

  // Method to handle bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // You can add navigation logic here depending on which tab is selected
    // For now, it will just update the selected index.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the product image (berries)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/berries.png',
                  height: 150,
                  width: 100,
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
              const Text(
                'RWF 100',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              // Quantity and Add to Cart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {},
                  ),
                  const Text(
                    '1',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Invoice Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildInvoiceItem('Original Price', 'RWF 500'),
                    _buildInvoiceItem('Delivery', '+ RWF 40', Colors.red),
                    _buildInvoiceItem('GST', '+ RWF 18', Colors.red),
                    _buildInvoiceItem('Discount', 'RWF 20'),
                    const Divider(),
                    _buildInvoiceItem('Total', 'RWF 538', Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Delivery Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Sebastian Ingabire'),
                    Text('House No 1, Sekimondo Estate'),
                    Text('Beside Ecole Sainte Rita, Bumbogo, Kigali'),
                    Text('079 XXX XXXX'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Add to Cart Button
              ElevatedButton(
                onPressed: () {
                  // Add to cart logic will be added here
                },
                // ignore: sort_child_properties_last
                child: const Text('Add to Cart'), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  // Helper widget to build invoice items
  Widget _buildInvoiceItem(String label, String amount, [Color? color]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          amount,
          style: TextStyle(color: color ?? Colors.black),
        ),
      ],
    );
  }
}
