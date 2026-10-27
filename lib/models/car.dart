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
        name: json['name'] ?? json['model'] ?? 'Unknown',
        price: (json['price'] ?? 0).toDouble(),
        image: json['image'] ?? '',
        description: json['description'] ?? 'Lorem ipsum dolor sit amet...',
      );
}