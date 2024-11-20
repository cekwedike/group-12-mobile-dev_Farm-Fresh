import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
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
      title: 'Sign In Screen with Provider',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignInScreen(),
    );
  }
}

class SignInProvider extends ChangeNotifier {
  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 32, // Increased font size for title
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Enter your email and password',
              style: TextStyle(
                fontSize: 14, // Smaller font size for subtitle
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Consumer<SignInProvider>(
              builder: (context, provider, child) {
                return TextField(
                  obscureText: provider.obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffix: GestureDetector(
                      onTap: provider.togglePasswordVisibility,
                      child: Text(
                        provider.obscurePassword
                            ? 'Show'
                            : 'Hide',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Keep the button green
                foregroundColor: Colors.black, // Change font color to black
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: const Text('LOGIN'),
            ),
            const SizedBox(height: 16.0),
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                // Navigate to the Sign-Up screen
                Navigator.pushNamed(context, '/sign_up');
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle Google sign in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In with Google',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Handle skip action
                Navigator.pushReplacementNamed(context, '/');
              },
              style: TextButton.styleFrom(),
              child: const Text('Skip now -->'),
            ),
          ],
        ),
      ),
    );
  }
}