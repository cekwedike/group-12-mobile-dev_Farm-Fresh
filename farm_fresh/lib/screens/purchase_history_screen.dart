// lib/screens/purchase_history_screen.dart
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
          _buildPurchaseItem('17 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
          _buildPurchaseItem('17 Agustus 2021', 'Game', 10.00, 'assets/game_icon.png'),
          _buildPurchaseItem('17 Agustus 2021', 'Credit & Quota', 34.00, 'assets/credit_icon.png'),
          _buildPurchaseItem('16 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
          _buildPurchaseItem('15 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
          _buildPurchaseItem('14 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
          _buildPurchaseItem('13 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
          _buildPurchaseItem('11 Agustus 2021', 'McDonald\'s', 34.00, 'assets/mcdonalds_logo.png'),
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
      ),
    );
  }

  Widget _buildPurchaseItem(String date, String merchant, double amount, String iconPath) {
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
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(iconPath, fit: BoxFit.contain),
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
                  '\$ ${amount.toStringAsFixed(2)}',
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