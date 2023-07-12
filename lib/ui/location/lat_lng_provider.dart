import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

final locationProvider = FutureProvider.family<LatLng?, String>((ref, postalCode) async {
  try {
    List<Location> locations = await locationFromAddress(postalCode);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;
      return LatLng(latitude, longitude);
    } else {
      throw Exception('No location found for the given postal code.');
    }
  } catch (error) {
    throw Exception('Error occurred while retrieving location: $error');
  }
});
