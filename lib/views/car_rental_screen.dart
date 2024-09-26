import 'package:flutter/material.dart';

import 'car_detail_screen.dart';

class CarRentalHome extends StatelessWidget {
  final double distance;
  const CarRentalHome({super.key, required this.distance});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Milan, Italy',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/cars-lamborghini-wallpaper-preview.jpg'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brands Section
              Text(
                'Brands',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    brandIcon('assets/images/audi-combination-mark.jpg'),
                    brandIcon('assets/images/audi-combination-mark.jpg'),
                    brandIcon('assets/images/audi-combination-mark.jpg'),
                    brandIcon('assets/images/audi-combination-mark.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Available Cars Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Cars Near You',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text('More')),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.3,
                width: MediaQuery.sizeOf(context).width*0.89,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return CarDetailScreen();
                          }));
                        },
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height*0.3,
                          width: MediaQuery.sizeOf(context).width*0.84,
                          child: Row(
                            children: [
                              carCard('Lamborghini', 'assets/images/cars-lamborghini-wallpaper-preview.jpg', 220, 4.9),
                              SizedBox(width: 12),
                              carCard('Tesla', 'assets/images/cars-lamborghini-wallpaper-preview.jpg', 350, 4.8),
                            ],
                          ),
                        ),
                      );
                    }),
              ),

              SizedBox(height: 12),

              SizedBox(height: 24),
              // Promo Section
              Text(
                'Promo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              promoCard('BMW 3', 'assets/images/cars-lamborghini-wallpaper-preview.jpg', 220),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget brandIcon(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 28,
        child: Image.asset(imagePath, height: 40),
      ),
    );
  }

  Widget carCard(String title, String imagePath, int pricePerDay, double rating) {
    return Expanded(
      child: Container(
        height: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 90),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('\$$pricePerDay/day'),
            Spacer(),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 16),
                SizedBox(width: 4),
                Text('$rating'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget promoCard(String title, String imagePath, int pricePerDay) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 80),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('\$$pricePerDay/day'),
            ],
          ),
        ],
      ),
    );
  }
}