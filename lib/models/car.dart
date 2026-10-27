class Car {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;

  Car({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json['id'] ?? 0,
        name: json['title'] ?? 'Unknown',
        price: (json['price'] ?? 0).toDouble(),
        image: json['thumbnail'] ?? '',
        description: json['description'] ?? 'No description',
      );
}