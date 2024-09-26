import '../../models/address_model.dart';
import '../../models/car_model.dart';

abstract class BookingEvent {}

class FetchAddressesEvent extends BookingEvent {}

class CalculateDistanceEvent extends BookingEvent {
  final Address pickup;
  final Address dropoff;

  CalculateDistanceEvent({required this.pickup, required this.dropoff});
}

class BookCarEvent extends BookingEvent {
  final String? name;
  final String? contact;
  final String? email;
  final Car? car;
  final double? distance;

  BookCarEvent({
    this.name,
    this.contact,
    this.email,
    this.car,
    this.distance,
  });
}
