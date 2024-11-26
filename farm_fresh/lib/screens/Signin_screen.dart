import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _obscurePassword = true;
  bool _isLoading = false;

  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      throw 'Please fill in all fields';
    }

    try {
      setLoading(true);

      // Firebase sign-in logic
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully signed in!')),
          );
          // Navigate to ExploreScreen on success
          Navigator.pushReplacementNamed(context, '/');
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-email':
          errorMessage = 'Wrong email/username. Try again';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        default:
          errorMessage = 'Wrong email/username. Try again';
      }
      throw errorMessage;
    } catch (e) {
      throw 'Wrong email/username. Try again';
    } finally {
      setLoading(false);
    }
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents keyboard overflow
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: Consumer<SignInProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60), // Added top padding
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
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        enabled: !provider.isLoading,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: passwordController,
                        obscureText: provider.obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffix: GestureDetector(
                            onTap: provider.togglePasswordVisibility,
                            child: Text(
                              provider.obscurePassword ? 'Show' : 'Hide',
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ),
                        ),
                        enabled: !provider.isLoading,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                                try {
                                  await provider.signInWithEmailAndPassword(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                        ),
                        child: Text(provider.isLoading ? 'SIGNING IN...' : 'LOGIN'),
                      ),
                      const SizedBox(height: 16.0),
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: provider.isLoading
                            ? null
                            : () {
                                Navigator.pushReplacementNamed(context, '/sign_up');
                              },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                      const SizedBox(height: 20), // Added bottom padding
                    ],
                  ),
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