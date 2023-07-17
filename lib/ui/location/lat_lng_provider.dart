import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:spenza/utils/spenza_extensions.dart';

final locationProvider =
    FutureProvider.family<Position?, String?>((ref, postalCode) async {

  final pref = await SharedPreferences.getInstance();

  try {
    List<Location> locations = await locationFromAddress(postalCode!);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(pref.getUserId())
          .update(
        {
          'location': GeoPoint(latitude, longitude),
          'zipCode': postalCode,
        },
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
      await storeZipCodeToServer(pref, postalCode);
      throw Exception('No location found for the given postal code.');
    }
  } catch (error) {
    await storeZipCodeToServer(pref, postalCode!);
    throw Exception('Error occurred while retrieving location: $error');
  }
});

Future<void> storeZipCodeToServer(SharedPreferences pref, String postalCode) async {
   await FirebaseFirestore.instance
      .collection('users')
      .doc(pref.getUserId())
      .update(
    {
      'zipCode': postalCode,
    },
  );


}
