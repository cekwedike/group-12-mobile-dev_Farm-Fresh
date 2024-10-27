// details.dart
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedIndex = 0;
  int _quantity = 1;
  final int berryPrice = 500;
  int _totalPrice = 500;

  // Delivery details
  String _name = 'Sebastian Ingabire';
  String _address = 'House No 1, Sekimondo Estate';
  String _city = 'Beside Ecole Sainte Rita, Bumbogo, Kigali';
  String _phone = '079 XXX XXXX';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 2:
        Navigator.pushNamed(context, '/purchase_history');
        break;
    }
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
      _totalPrice = _quantity * berryPrice;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _totalPrice = _quantity * berryPrice;
      });
    }
  }

  Future<void> _navigateToEditDeliveryScreen() async {
    final updatedDetails = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditDeliveryScreen(),
      ),
    );

    if (updatedDetails != null && updatedDetails is Map<String, String>) {
      setState(() {
        _name = updatedDetails['name'] ?? _name;
        _address = updatedDetails['address'] ?? _address;
        _city = updatedDetails['city'] ?? _city;
        _phone = updatedDetails['phone'] ?? _phone;
      });
    }
  }

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
              Text(
                'RWF $_totalPrice',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decreaseQuantity,
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                    _buildInvoiceItem('Original Price', 'RWF $_totalPrice'),
                    _buildInvoiceItem('Delivery', '+ RWF 40', Colors.red),
                    _buildInvoiceItem('GST', '+ RWF 18', Colors.red),
                    _buildInvoiceItem('Discount', 'RWF 20'),
                    const Divider(),
                    _buildInvoiceItem('Total', 'RWF ${_totalPrice + 40 + 18 - 20}', Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: _navigateToEditDeliveryScreen,
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(_name),
                    Text(_address),
                    Text(_city),
                    Text(_phone),
                  ],
                ),
              ),
              const SizedBox(height: 10, width: double.infinity),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1B8E3D),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
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
        onTap: _onItemTapped,
      ),
    );
  }

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

// edit_delivery_screen.dart

class EditDeliveryScreen extends StatefulWidget {
  const EditDeliveryScreen({super.key});

  @override
  _EditDeliveryScreenState createState() => _EditDeliveryScreenState();
}

class _EditDeliveryScreenState extends State<EditDeliveryScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveDetails() {
    // Prepare the updated data
    final updatedDetails = {
      'name': _nameController.text,
      'address': _addressController.text,
      'city': _cityController.text,
      'phone': _phoneController.text,
    };

    // Return to previous screen with the updated data
    Navigator.pop(context, updatedDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Delivery Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDetails,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
