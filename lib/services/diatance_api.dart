import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class DistanceApi {
  Future<double> getDistance(double pickupLat, double pickupLng, double dropoffLat, double dropoffLng) async {
    final url = 'http://router.project-osrm.org/route/v1/driving/$pickupLng,$pickupLat;$dropoffLng,$dropoffLat?overview=false';

    // Make the API call (but ignore the response for distance)
    try {
      final response = await http.get(Uri.parse(url));

    } catch (e) {
      print('Error occurred during API call: $e. Returning random distance.');
    }

    // Generate a random distance between 1 and 100 km
    Random random = Random();
    double randomDistance = 1 + random.nextInt(100) + random.nextDouble();

    print('Returning random distance: $randomDistance km');

    return randomDistance;
  }
}
