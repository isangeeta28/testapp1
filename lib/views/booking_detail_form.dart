import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../models/car_model.dart';
import 'booking_list_screen.dart';

class BookingDetailsForm extends StatefulWidget {
  @override
  _BookingDetailsFormState createState() => _BookingDetailsFormState();
}

class _BookingDetailsFormState extends State<BookingDetailsForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  Car? selectedCar; // Variable to hold the selected car

  // Example cars data (replace this with your actual data)
  List<Car> cars = [
    Car(name: "Toyota Camry", price: 25000),
    Car(name: "Honda Accord", price: 24000),
    Car(name: "Ford Mustang", price: 35000),
    Car(name: "Tesla Model 3", price: 45000),
    Car(name: "Chevrolet Impala", price: 23000),
  ];

  // Function to validate email format
  String? _validateEmail(String? value) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Function to validate name
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  // Function to validate contact number
  String? _validateContact(String? value) {
    final RegExp phoneRegex = RegExp(r'^[0-9]+$');
    if (value == null || value.isEmpty) {
      return 'Contact is required';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid contact number';
    }
    return null;
  }

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with submission logic
      final String name = nameController.text;
      final String contact = contactController.text;
      final String email = emailController.text;
      double distance; // You should get the calculated distance from your state or logic
      // For example: distance = context.read<YourDistanceBloc>().state.distance;

      // Call the booking method
      final bookingEvent = BookCarEvent(
        name: name,
        contact: contact,
        email: email,
        car: Car(name: "Toyota Camry", price: 25000),
      );

      // Dispatch the booking event
      context.read<BookingBloc>().add(bookingEvent);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking submitted successfully!')),
      );

      // Navigate to the Booking List Screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return BookingListScreen();
      }));
    } else {
      // If the form is not valid, show errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill the form')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Contact Information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Please Fill Out Your Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Name Field
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.black87),
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Colors.black87, width: 2),
                    ),
                    hintText: 'Enter your full name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: _validateName,
                ),
                SizedBox(height: 16),
                // Contact Field
                TextFormField(
                  controller: contactController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.black87),
                    labelText: 'Contact',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Colors.black87, width: 2),
                    ),
                    hintText: 'Enter your contact number',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: _validateContact,
                ),
                SizedBox(height: 16),
                // Email Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.black87),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Colors.black87, width: 2),
                    ),
                    hintText: 'Enter your email address',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: 30),
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Book',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
