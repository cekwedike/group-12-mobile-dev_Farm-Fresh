import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isEditing = false;
  bool _isLoading = false;

  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';
  String _deliveryAddress = '';

  bool get isEditing => _isEditing;
  bool get isLoading => _isLoading;
  String get fullName => _fullName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get deliveryAddress => _deliveryAddress;

  Future<void> initializeProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        _email = user.email ?? '';
        
        final userData = await _firestore.collection('users').doc(user.uid).get();
        
        if (userData.exists) {
          final data = userData.data() as Map<String, dynamic>;
          _fullName = data['fullName'] ?? '';
          _phoneNumber = data['phoneNumber'] ?? '';
          _address = data['address'] ?? '';
          _deliveryAddress = data['deliveryAddress'] ?? '';
        } else {
          _fullName = user.displayName ?? '';
        }
      }
    } catch (e) {
      debugPrint('Error initializing profile: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String deliveryAddress,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(fullName);

        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': user.email,
          'phoneNumber': phoneNumber,
          'address': address,
          'deliveryAddress': deliveryAddress,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        _fullName = fullName;
        _phoneNumber = phoneNumber;
        _address = address;
        _deliveryAddress = deliveryAddress;
        _isEditing = false;
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _deliveryAddressController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _deliveryAddressController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().initializeProfile().then((_) {
        final provider = context.read<ProfileProvider>();
        _fullNameController.text = provider.fullName;
        _emailController.text = provider.email;
        _phoneController.text = provider.phoneNumber;
        _addressController.text = provider.address;
        _deliveryAddressController.text = provider.deliveryAddress;
      });
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _deliveryAddressController.dispose();
    super.dispose();
  }

  Widget _buildOptionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B8E3D)),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Color(0xFF1B8E3D),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B8E3D),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFF1B8E3D),
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.fullName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                provider.email,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              provider.isEditing ? Icons.close : Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: provider.toggleEdit,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Options Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          _buildOptionTile(
                            title: 'Balance',
                            icon: Icons.account_balance_wallet_outlined,
                            onTap: () => Navigator.pushNamed(context, '/balance'),
                          ),
                          const Divider(height: 1),
                          _buildOptionTile(
                            title: 'Purchase History',
                            icon: Icons.history,
                            onTap: () => Navigator.pushNamed(context, '/purchase_history'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _fullNameController,
                            enabled: provider.isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            enabled: provider.isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Addresses',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _addressController,
                            enabled: provider.isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Primary Address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.home_outlined),
                            ),
                            maxLines: 2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _deliveryAddressController,
                            enabled: provider.isEditing,
                            decoration: const InputDecoration(
                              labelText: 'Delivery Address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.local_shipping_outlined),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 24),
                          if (provider.isEditing)
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await provider.updateProfile(
                                      fullName: _fullNameController.text,
                                      phoneNumber: _phoneController.text,
                                      address: _addressController.text,
                                      deliveryAddress: _deliveryAddressController.text,
                                    );
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Profile updated successfully'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Failed to update profile'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B8E3D),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Save Changes'),
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              await provider.signOut();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, '/sign_in');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Sign Out'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF1B8E3D),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cart');
          }
        },
      ),
    );
  }
}