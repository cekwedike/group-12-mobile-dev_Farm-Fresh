// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/purchase_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Fresh',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PurchaseHistoryScreen(),
    );
  }
}