import 'dart:async';

import 'package:carideapp/views/pick_location_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   // Add a delay before navigating to the main screen
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width*0.9999,
        decoration: BoxDecoration(
         color: Colors.black87
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            // Placeholder for a logo or image
            Image.asset('assets/images/cars-lamborghini-wallpaper-preview.jpg',
              height: 290,),
            SizedBox(height: 30),
            // App title or tagline
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Luxury Car Rental in India',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rent a car online Today & Enjoy the Best Deals, Rates and Accessories',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height:MediaQuery.sizeOf(context).height*0.2),

                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                          return PickLocationScreen();
                        }));
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width*0.88,
                        height: MediaQuery.sizeOf(context).height*0.06,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Center(
                            child: Text("Let's Go",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),)
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
