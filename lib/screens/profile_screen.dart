import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 60)),
          SizedBox(height: 16),
          Text('Utilisateur', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('user@example.com', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}