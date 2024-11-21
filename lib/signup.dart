import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate based on user role (Owner or Tenant)
      if (user.user != null) {
        // Check role in Firestore (tenant/owner)
        var userData = await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).get();
        String role = userData['role'];

        if (role == 'owner') {
          Navigator.pushReplacementNamed(context, '/ownerDashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/tenantDashboard');
        }
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
          ElevatedButton(onPressed: signIn, child: Text('Sign In')),
        ],
      ),
    );
  }
}