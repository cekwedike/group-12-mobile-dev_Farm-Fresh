import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CustomScreen(),
    );
  }
}

class CustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main large logo with shadow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent, // Changed to transparent
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5), // Green shadow
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.jpg', // Path to the logo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Top logo with shadow
            Positioned(
              bottom: 60, // Adjusted position to center above the large circle
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Changed to transparent
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5), // Green shadow
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.jpg', // Path to the logo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Bottom logo with shadow
            Positioned(
              top: 60, // Adjusted position to center below the large circle
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Changed to transparent
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5), // Green shadow
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.jpg', // Path to the logo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
