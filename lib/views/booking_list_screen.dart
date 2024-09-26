import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/booking_model.dart';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  // Method to load bookings from SharedPreferences
  void _loadBookings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? bookingList = prefs.getStringList('bookings') ?? [];

    // Convert JSON strings back to Booking objects, excluding the car details
    setState(() {
      bookings = bookingList!.map((bookingJson) {
        final bookingData = json.decode(bookingJson);
        return Booking(
          name: bookingData['name'],
          contact: bookingData['contact'],
          email: bookingData['email'],
          distance: bookingData['distance'],
          // If your Booking model needs a Car object, you can pass null or handle it as needed
          car: null, // Setting car to null, or you could customize this
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Booking List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: bookings.isEmpty
          ? Center(child: Text('No bookings found.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black87,
                child: Text(
                  booking.car?.name[0] ?? 'C', // Display the first letter of the car's name
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              title: Text(
                '${booking.name} booked ${booking.car?.name ?? "a car"}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Contact: ${booking.contact}\nEmail: ${booking.email}\nDistance: ${booking.distance} km',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Text(
                '\$${booking.car?.price?.toStringAsFixed(2) ?? "0.00"}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
