import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_state.dart';
import '../models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_state.dart';
import '../models/address_model.dart';

class PickupDropoffDropdown extends StatefulWidget {
  final bool isPickup;
  final Function(Address) onLocationSelected;

  const PickupDropoffDropdown({Key? key, required this.isPickup, required this.onLocationSelected}) : super(key: key);

  @override
  _PickupDropoffDropdownState createState() => _PickupDropoffDropdownState();
}

class _PickupDropoffDropdownState extends State<PickupDropoffDropdown> {
  Address? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is AddressesLoadedState) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for better alignment
            child: DropdownButtonHideUnderline( // Hides the default underline of the dropdown
              child: DropdownButton<Address>(
                hint: Text(
                  widget.isPickup ? 'Select Pickup Location' : 'Select Dropoff Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _selectedLocation,
                onChanged: (Address? newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                  if (newValue != null) {
                    widget.onLocationSelected(newValue);
                  }
                },
                items: state.addresses.map<DropdownMenuItem<Address>>((Address address) {
                  return DropdownMenuItem<Address>(
                    value: address,
                    child: Text(
                      address.address,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black87,
                  size: 24,
                ),
                dropdownColor: Colors.white, // Background of the dropdown items
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                // Handle long lists with a scrollable container
               // menuMaxHeight: MediaQuery.of(context).size.height * 0.4, // Set maximum height for dropdown
              ),
            ),
          );
        } else if (state is AddressesLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
            ),
          );
        } else if (state is BookingErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        } else {
          return Center(
              child: Text(
              'No addresses available',
              style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
          ),
        ));
      }
      },
    );
  }
}

