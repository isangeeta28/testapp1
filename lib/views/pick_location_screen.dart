import 'package:carideapp/views/car_rental_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../models/address_model.dart';
import '../services/diatance_api.dart';
import '../utils/pickup_and_dropdown.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  Address? _selectedPickup;
  Address? _selectedDropoff;
  double? _distance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => BookingBloc(distanceApi: DistanceApi())..add(FetchAddressesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Car Booking', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pickup Location Dropdown
              Text('Pickup Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 10),
              PickupDropoffDropdown(
                isPickup: true,
                onLocationSelected: (Address location) {
                  _selectedPickup = location;
                },
              ),

              // Dropoff Location Dropdown
              SizedBox(height: 20),
              Text('Dropoff Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 10),
              PickupDropoffDropdown(
                isPickup: false,
                onLocationSelected: (Address location) {
                  _selectedDropoff = location;
                },
              ),

              // Calculate Distance Button with Error Handling
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.25, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    if (_selectedPickup != null && _selectedDropoff != null) {
                      // Fetch the distance from DistanceApi
                      final distanceApi = DistanceApi();
                      final randomDistance = await distanceApi.getDistance(
                        _selectedPickup!.latitude,
                        _selectedPickup!.longitude,
                        _selectedDropoff!.latitude,
                        _selectedDropoff!.longitude,
                      );

                      // Navigate to InfoScreen and pass the random distance
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CarRentalHome(distance: randomDistance);
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please select both pickup and dropoff locations'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text('Calculate Distance', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),

              SizedBox(height: screenHeight * 0.05), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
