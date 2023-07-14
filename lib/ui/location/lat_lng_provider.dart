import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/spenza_extensions.dart';

final locationProvider =
    FutureProvider.family<Position?, String?>((ref, postalCode) async {
  try {
    List<Location> locations = await locationFromAddress(postalCode!);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      final pref = await SharedPreferences.getInstance();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(pref.getUserId())
          .set(
        {
          'location': GeoPoint(latitude, longitude),
        },
        SetOptions(merge: true),
      );

      return Position(
          longitude: longitude,
          latitude: latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    } else {
      throw Exception('No location found for the given postal code.');
    }
  } catch (error) {
    throw Exception('Error occurred while retrieving location: $error');
  }
});
