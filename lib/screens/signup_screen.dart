import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final DBHelper _db = DBHelper();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
      await _db.registerUser(user);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte créé avec succès !')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.directions_car, size: 80, color: Colors.amber),
              const SizedBox(height: 16),
              const Text('Create Your Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF009688))),
              const SizedBox(height: 24),
              _buildField(_nameCtrl, 'Name', Icons.person),
              const SizedBox(height: 16),
              _buildField(_emailCtrl, 'Email', Icons.email,
                  validator: (v) => v!.contains('@') ? null : 'Email invalide'),
              const SizedBox(height: 16),
              _buildField(_passCtrl, 'Password', Icons.lock, obscure: true,
                  validator: (v) => v!.length < 6 ? '6 caractères minimum' : null),
              const SizedBox(height: 16),
              _buildField(_confirmCtrl, 'Confirm Password', Icons.lock_outline,
                  obscure: true,
                  validator: (v) => v != _passCtrl.text ? 'Ne correspond pas' : null),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009688)),
                  onPressed: _signUp,
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon,
      {bool obscure = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      validator: validator ??
          (v) => v!.isEmpty ? 'Champ requis' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}