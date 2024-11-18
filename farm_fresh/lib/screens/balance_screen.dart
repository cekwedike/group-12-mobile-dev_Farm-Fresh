import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
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
      title: 'Balance Screen with Provider',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const BalanceScreen(),
    );
  }
}

class BalanceProvider extends ChangeNotifier {
  bool _balanceVisible = true;

  bool get balanceVisible => _balanceVisible;

  void toggleBalanceVisibility() {
    _balanceVisible = !_balanceVisible;
    notifyListeners();
  }
}

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Balance Card
            Consumer<BalanceProvider>(
              builder: (context, provider, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Balance', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          Text(
                            provider.balanceVisible ? 'RWF 100,000' : '******',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          provider.balanceVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          provider.toggleBalanceVisibility();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Top Up Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/top_up');
              },
              child: const Text('Top Up'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Profile is selected
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
          // Handle bottom navigation tap
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
}