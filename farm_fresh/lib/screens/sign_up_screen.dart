import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context, {
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || fullName.isEmpty) {
      throw 'Please fill all fields';
    }

    if (password != confirmPassword) {
      throw 'Passwords do not match';
    }

    if (password.length < 6) {
      throw 'Password should be at least 6 characters';
    }

    if (!email.contains('@')) {
      throw 'Please enter a valid email address';
    }

    try {
      setLoading(true);
      
      // Create user with Firebase Authentication
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        // Update the user's display name
        await userCredential.user!.updateDisplayName(fullName);
        
        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account created successfully")),
          );
          
          // Navigate to sign in screen
          Navigator.pushReplacementNamed(context, '/sign_in');
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          errorMessage = 'Please enter a stronger password';
          break;
        default:
          errorMessage = 'An error occurred during registration';
      }
      throw errorMessage;
    } catch (e) {
      throw 'An unexpected error occurred';
    } finally {
      setLoading(false);
    }
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      body: Consumer<SignUpProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'First create your account',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full name',
                        border: OutlineInputBorder(),
                      ),
                      enabled: !provider.isLoading,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      enabled: !provider.isLoading,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: provider.obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            provider.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: provider.togglePasswordVisibility,
                        ),
                      ),
                      enabled: !provider.isLoading,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: provider.obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm your password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            provider.obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: provider.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      enabled: !provider.isLoading,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: provider.isLoading
                          ? null
                          : () async {
                              try {
                                await provider.signUp(
                                  context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                  fullName: fullNameController.text,
                                );
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            },
                      child: Text(provider.isLoading ? 'SIGNING UP...' : 'SIGN UP'),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: provider.isLoading
                                ? null
                                : () {
                                    Navigator.pushReplacementNamed(context, '/sign_in');
                                  },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!provider.isLoading)
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: const Text('Skip now -->'),
                        ),
                      ),
                  ],
                ),
              ),
              if (provider.isLoading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}