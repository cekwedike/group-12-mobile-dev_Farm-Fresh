import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Generate a random duration between 12 to 15 seconds
    final int randomSeconds = Random().nextInt(4) + 12;  // 12-15 seconds

    Timer(Duration(seconds: randomSeconds), () {
      if (mounted) {  // Check if widget is still mounted
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacementNamed(context, '/explore');
        } else {
          Navigator.pushReplacementNamed(context, '/sign_in');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,  // Prevent back button during splash
      child: Scaffold(
        backgroundColor: const Color(0xFF1B8E3D),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating small circles
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // First rotating circle
                        Positioned(
                          top: -20,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Second rotating circle
                        Positioned(
                          bottom: -20,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Center fixed circle with loading indicator
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.wb_sunny_outlined,
                    color: Color(0xFF1B8E3D),
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}