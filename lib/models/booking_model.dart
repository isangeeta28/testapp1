

import 'car_model.dart';

class Booking {
  final String name;
  final String contact;
  final String email;
  final Car? car;
  final double distance;

  Booking({
    required this.name,
    required this.contact,
    required this.email,
    this.car,
    required this.distance,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact,
      'email': email,
      'car': car?.name,
      'price': car?.price,
      'distance': distance,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      name: json['name'],
      contact: json['contact'],
      email: json['email'],
      car: Car.fromJson(json['car']),
      distance: json['distance'],
    );
  }
}
