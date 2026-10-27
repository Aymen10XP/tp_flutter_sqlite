import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final DBHelper _db = DBHelper();

  void _login() async {
    final user = await _db.loginUser(
        _emailCtrl.text.trim(), _passCtrl.text.trim());
    if (!mounted) return;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenue ${user.name} !')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou mot de passe incorrect')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.directions_car, size: 100, color: Colors.amber),
            const SizedBox(height: 16),
            const Text('Welcome Back!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF009688))),
            const Text('Please sign in to your account',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688)),
                onPressed: _login,
                child: const Text('Sign in',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen())),
              child: const Text("Don't have an account? Sign Up",
                  style: TextStyle(color: Color(0xFF009688))),
            ),
          ],
        ),
      ),
    );
  }
}