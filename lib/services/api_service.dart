import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class ApiService {
  // ✅ Free API, no key needed
  static const String url = 'https://dummyjson.com/products?limit=10';

  static Future<List<Car>> fetchCars() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'] ?? [];
      return products.map((e) => Car.fromJson(e)).toList();
    } else {
      throw Exception('Erreur API: ${response.statusCode}');
    }
  }
}