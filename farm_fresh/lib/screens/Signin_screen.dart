import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/explorescreen.dart'; // Correct import for ExploreScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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
      title: 'Firebase Sign In',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const FarmFreshScreen(); // Logged in
          } else {
            return const SignInScreen(); // Not logged in
          }
        },
      ),
      routes: {
        '/explorescreen': (context) => const FarmFreshScreen(),
      },
    );
  }
}

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // Firebase sign-in logic
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Confirm that user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed in!')),
        );
        // Navigate to ExploreScreen on success
        Navigator.pushNamed(context, '/explorescreen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
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
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Consumer<SignInProvider>(
              builder: (context, provider, child) {
                return TextField(
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
                );
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text;

                if (email.isNotEmpty && password.isNotEmpty) {
                  Provider.of<SignInProvider>(context, listen: false)
                      .signInWithEmailAndPassword(context, email, password);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: const Text('LOGIN'),
            ),
            const SizedBox(height: 16.0),
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/explorescreen');
              },
              child: const Text(
                'Explore Screen',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
