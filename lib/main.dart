import 'package:carideapp/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/booking/booking_bloc.dart';
import 'services/diatance_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>  BookingBloc(distanceApi: DistanceApi()),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Booking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
            bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          ),
        ),
        home: SplashScreen()
      ),
    );
  }
}

