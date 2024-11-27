import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import './screens/Signin_screen.dart';
import './screens/explorescreen.dart';
import './screens/purchase_history_screen.dart';
import './screens/details.dart';
import './screens/profile.dart';
import './screens/sign_up_screen.dart';
import './screens/balance_screen.dart';
import './screens/cart_screen.dart';
import './screens/topupscreen.dart';
import './screens/splash_screen.dart';
import './screens/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExploreProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseHistoryProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => TopUpProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData && FirebaseAuth.instance.currentUser != null) {
          return const FarmFreshScreen();
        }

        return const SignInScreen();
      },
    );
  }
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
      home: const SplashScreen(),  // Set SplashScreen as initial screen
      routes: {
        '/': (context) => const AuthWrapper(),
        '/sign_in': (context) => const SignInScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/purchase_history': (context) => const PurchaseHistoryScreen(),
        '/product_details': (context) => const ProductDetailScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/balance': (context) => const BalanceScreen(),
        '/cart': (context) => const CartPage(),
        '/top_up': (context) => const TopUpScreen(),
        '/explore': (context) => const FarmFreshScreen(),
      },
    );
  }
}