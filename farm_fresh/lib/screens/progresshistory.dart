import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PurchaseHistoryScreen(),
    );
  }
}

class PurchaseHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // Implement back navigation
          },
        ),
        title: Text(
          'Purchase History',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildListTile('17 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
            buildListTile('17 August 2021', 'Game', '\$10.00', Icons.sports_esports, Colors.green),
            buildListTile('17 August 2021', 'Credit & Quota', '\$34.00', Icons.credit_card, Colors.red),
            buildListTile('16 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
            buildListTile('15 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
            buildListTile('14 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
            buildListTile('13 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
            buildListTile('11 August 2021', 'McDonald\'s', '\$34.00', Icons.fastfood, Colors.yellow),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Set the default selected item to Profile
        items: [
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

  Widget buildListTile(String date, String title, String amount, IconData icon, Color iconColor) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(amount),
      onTap: () {
        // Implement navigation to detailed purchase page if needed
      },
    );
  }
}
