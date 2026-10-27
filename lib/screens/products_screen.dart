import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/car.dart';
import '../services/api_service.dart';
import 'car_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = ApiService.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: _carsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucune voiture disponible'));
        }
        final cars = snapshot.data!;
        return ListView(
          children: [
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 220,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              items: cars.map((car) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(car.image, fit: BoxFit.cover, width: 400),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ...cars.map((car) => _buildCarCard(car)),
          ],
        );
      },
    );
  }

  Widget _buildCarCard(Car car) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CarDetailScreen(car: car)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(car.image,
                  height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(car.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('\$${car.price.toStringAsFixed(0)}',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Achat simulé : ${car.name}')),
                    );
                  },
                  icon: const Icon(Icons.attach_money, color: Colors.white),
                  label: const Text('Buy Car',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}