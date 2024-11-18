import 'dart:async';
import 'dart:math';
import 'package:farm_fresh/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:farm_fresh/screens/explorescreen.dart';
import 'package:farm_fresh/screens/purchase_history_screen.dart';
import 'package:farm_fresh/screens/details.dart';
import 'package:farm_fresh/screens/profile.dart';
import 'package:farm_fresh/screens/sign_up_screen.dart';
import 'package:farm_fresh/screens/balance_screen.dart';
import 'package:farm_fresh/screens/signin_screen.dart';
import 'package:farm_fresh/screens/cart_screen.dart';
import 'package:farm_fresh/screens/topupscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExploreProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseHistoryProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => TopUpProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
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
        '/cart': (context) => const CartPage(),
        '/splash_screen': (context) => const SplashScreen(),
        '/sign_in': (context) => const SignInScreen(),
        '/top_up': (context) => const TopUpScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Generate a random delay between 8 to 12 seconds
    final int randomSeconds = Random().nextInt(5) + 8;
    
    Timer(Duration(seconds: randomSeconds), () {
      Navigator.pushReplacementNamed(context, '/sign_up');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Farm Fresh!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                // Main large logo with shadow
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade800.withOpacity(0.5),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Top logo with shadow
                Positioned(
                  bottom: 60,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Bottom logo with shadow
                Positioned(
                  top: 60,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
