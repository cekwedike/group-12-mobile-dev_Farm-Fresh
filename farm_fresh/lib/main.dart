// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/explorescreen.dart';
import 'screens/purchase_history_screen.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Fresh',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B8E3D),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FarmFreshScreen(),
        '/purchase_history': (context) => const PurchaseHistoryScreen(),
      },
    );
  }
}