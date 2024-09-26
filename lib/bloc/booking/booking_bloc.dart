import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address_model.dart';
import '../../models/booking_model.dart';
import '../../models/car_model.dart';
import '../../services/diatance_api.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final DistanceApi distanceApi;

  BookingBloc({required this.distanceApi}) : super(BookingInitial()) {
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<CalculateDistanceEvent>(_onCalculateDistance);
    on<BookCarEvent>(_onBookCar);
  }

  void _onFetchAddresses(FetchAddressesEvent event, Emitter<BookingState> emit) async {
    try {
      emit(AddressesLoadingState());

      // Load the JSON file
      final String response = await rootBundle.loadString('assets/address.json');
      final List<dynamic> data = json.decode(response);

      // Check if the data is a list
      if (data is! List) {
        emit(BookingErrorState(message: 'Loaded data is not a list', distance: 23.00, cars: []));
        return;
      }

      // Map the JSON data to a list of Address objects
      List<Address> addresses = data.map((address) => Address.fromJson(address)).toList();

      emit(AddressesLoadedState(addresses: addresses));
    } catch (e) {
      emit(BookingErrorState(message: 'Failed to load addresses: $e', distance: 23.00, cars: []));
    }
  }

  void _onCalculateDistance(CalculateDistanceEvent event, Emitter<BookingState> emit) async {
    try {
      // Emit loading state while calculation is in progress
      emit(AddressesLoadingState());

      // Attempt to fetch the distance from the API
      final distance = await distanceApi.getDistance(
        event.pickup.latitude,
        event.pickup.longitude,
        event.dropoff.latitude,
        event.dropoff.longitude,
      );

      // Generate random cars (even on success)
      final cars = List.generate(5, (index) => Car(name: 'Car $index', price: (index + 1) * 1000.0));

      // Emit the DistanceCalculatedState with the calculated distance and generated cars
      emit(DistanceCalculatedState(distance: distance, cars: cars));

    } catch (e) {
      // Handle the error case by returning a random distance and cars
      print('Error occurred during API call: $e. Returning random distance.');

      // Generate random distance and cars
      double randomDistance = Random().nextDouble() * 100 + 1; // Generate random distance between 1 and 100
      final cars = List.generate(5, (index) => Car(name: 'Car $index', price: (index + 1) * 1000.0));

      print('Returning random distance: $randomDistance km');

      // Emit the DistanceCalculatedState with random distance and cars
      emit(DistanceCalculatedState(distance: randomDistance, cars: cars));
    }
  }

  // Booking a car and saving the booking to local storage
  void _onBookCar(BookCarEvent event, Emitter<BookingState> emit) async {
    try {
      // Create a booking object
      final booking = Booking(
        name: event.name??"",
        contact: event.contact??"",
        email: event.email??"",
        distance: event.distance??23.00,
      );

      // Save booking details to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? bookings = prefs.getStringList('bookings') ?? [];

      // Convert the booking to JSON and add it to the list
      bookings?.add(json.encode(booking.toJson()));

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('bookings', bookings!);

      // Emit the success state
      emit(BookingSuccessState(booking: booking));
    } catch (e) {
      emit(BookingErrorState(message: 'Booking failed.', distance: event.distance??23.00, cars: []));
    }
  }
}
