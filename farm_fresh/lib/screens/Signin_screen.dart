import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignInScreen(),
      routes: {
        '/sign_up': (context) => const SignUpScreen(), // Ensure this is defined elsewhere
        '/': (context) => const FarmFreshScreen(), // Ensure this is defined elsewhere
      },
    );
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
                fontSize: 32, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Enter your email and password',
              style: TextStyle(
                fontSize: 14,
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
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffix: GestureDetector(
                  onTap: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: const Text('LOGIN'),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Navigate to Sign Up screen
                Navigator.pushNamed(context, '/sign_up');
              },
              child: const Text("Don't have an account? Sign up",
                  style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle Google sign in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
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
                // Navigate to FarmFreshScreen
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
