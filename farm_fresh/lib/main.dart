import 'dart:async';  // For Timer
import 'dart:math';   // For generating random numbers
import 'package:flutter/material.dart';
import 'package:farm_fresh/screens/explorescreen.dart';
import 'package:farm_fresh/screens/purchase_history_screen.dart';
import 'package:farm_fresh/screens/details.dart';
import 'package:farm_fresh/screens/profile.dart';
import 'package:farm_fresh/screens/sign_up_screen.dart';
import 'package:farm_fresh/screens/balance_screen.dart';
import 'package:farm_fresh/screens/signin_screen.dart';
import 'package:farm_fresh/screens/cart_screen.dart';

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1B8E3D)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1B8E3D),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/': (context) => const FarmFreshScreen(),
        '/purchase_history': (context) => const PurchaseHistoryScreen(),
        '/product_details': (context) => const ProductDetailScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/balance': (context) => const BalanceScreen(),
        '/cart' : (context) => const CartPage(),
        '/balance_screen' : (context) => const BalanceScreen(),
        '/splash_screen' : (context) => const SplashScreen(),
        '/sign_in' : (context) => const SignInScreen(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a random delay between 8 to 12 seconds
    final int randomSeconds = Random().nextInt(5) + 8;  // Random number between 8 and 12

    // Navigate after a random delay
    Timer(Duration(seconds: randomSeconds), () {
      Navigator.pushReplacementNamed(context, '/sign_up');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Farm Fresh!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading...', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}