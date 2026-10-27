import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 80, color: Color(0xFF009688)),
            SizedBox(height: 16),
            Text('À propos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Application de vente de voitures développée dans le cadre du TP N°4 Flutter.',
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}