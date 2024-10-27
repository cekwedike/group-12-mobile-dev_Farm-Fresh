import 'package:flutter/material.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Purchase History',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildPurchaseItem('17 August 2021', 'Strawberries', 15500,
              'assets/berries.jpg'),
          _buildPurchaseItem(
              '17 August 2021', 'Cranberries', 22800, 'assets/berries.jpg'),
          _buildPurchaseItem('17 August 2021', 'Raspberries', 18900,
              'assets/berries.jpg'),
          _buildPurchaseItem('16 August 2021', 'Cranberries', 12500,
              'assets/berries.jpg'),
          _buildPurchaseItem('15 August 2021', 'Raspberries', 27600,
              'assets/berries.jpg'),
          _buildPurchaseItem('14 August 2021', 'Strawberries', 19800,
              'assets/berries.jpg'),
          _buildPurchaseItem('13 August 2021', 'Raspberries', 23400,
              'assets/berries.jpg'),
          _buildPurchaseItem('11 August 2021', 'Cranberries', 16700,
              'assets/berries.jpg'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
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
        onTap: (index) {
          // Handle navigation
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }

  Widget _buildPurchaseItem(
      String date, String merchant, double amount, String iconPath) {
    // Format the amount with thousand separators
    String formattedAmount = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'RWF $formattedAmount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}