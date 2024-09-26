import 'package:flutter/material.dart';

import 'booking_detail_form.dart';

class CarDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Text(
          'Lamborghini Aventador LP780-4',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Title

            SizedBox(height: 8),
            // Car Image
            Center(
              child: Image.asset(
                'assets/images/audi-combination-mark.jpg',
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            // Renter point
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/cars-lamborghini-wallpaper-preview.jpg'),
                  radius: 20,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Joss Angel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'St. Jane, Chicago',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            // Specifications Section
            Text(
              'Specification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                specItem(Icons.speed, 'Engine power', '560 HP'),
                specItem(Icons.flash_on, 'Max speed', '320 km/h'),
                specItem(Icons.event_seat, 'Seats', '2 seats'),
              ],
            ),
            SizedBox(height: 24),
            // Location and destination
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '447 4th St, Jane, Chicago',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Where you go?',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Spacer(),
            // Price and Rent Now button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$220/day',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return BookingDetailsForm();
                      })
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 16), backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Rent Now',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget specItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.black),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}