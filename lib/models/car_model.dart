class Car {
  final String name;
  final double price;

  Car({required this.name, required this.price});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json['name'],
      price: json['price'],
    );
  }
}
