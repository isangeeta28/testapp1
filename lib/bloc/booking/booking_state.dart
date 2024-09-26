import '../../models/address_model.dart';
import '../../models/booking_model.dart';
import '../../models/car_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class AddressesLoadingState extends BookingState {}

class AddressesLoadedState extends BookingState {
  final List<Address> addresses;

  AddressesLoadedState({required this.addresses});
}

class DistanceCalculatedState extends DistanceState {
  DistanceCalculatedState({required double distance, required List<Car> cars})
      : super(distance: distance, cars: cars);
}

class BookingSuccessState extends BookingState {
  final Booking booking;

  BookingSuccessState({required this.booking});
}

class BookingErrorState extends DistanceState {
  final String message;

  BookingErrorState({
    required this.message,
    required double distance,
    required List<Car> cars,
  }) : super(distance: distance, cars: cars);
}

// Base state that holds the distance and cars
abstract class DistanceState extends BookingState {
  final double distance;
  final List<Car> cars;

  DistanceState({required this.distance, required this.cars});
}






