import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'details.dart'; // This is details screen

void main() {
  runApp(const ProviderScope(child: MyApp())); // Wraped with ProviderScope since I am using Riverpod
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailScreen(), // Load the ProductDetailScreen from details.dart
    );
  }
}
