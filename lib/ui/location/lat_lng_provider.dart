import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/spenza_extensions.dart';

final locationProvider =
    FutureProvider.family<LatLng?, String>((ref, postalCode) async {
  try {
    List<Location> locations = await locationFromAddress(postalCode);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      final pref = await SharedPreferences.getInstance();

      // Check if the location field exists in Firestore.
      /*final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(pref.getUserId())
          .get();

      // If the location field does not exist, create it.
      if (!document.exists || !document.data().containsKey('location')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(pref.getUserId())
            .update({'location': GeoPoint(latitude, longitude)});
      } else {
        // If the location field exists, update it.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(pref.getUserId())
            .update({'location': GeoPoint(latitude, longitude)});
      }*/


      await FirebaseFirestore.instance.collection('users').doc(pref.getUserId()).set(
        {
          'location': GeoPoint(latitude, longitude),
        },
        SetOptions(merge: true),
      );

      return LatLng(latitude, longitude);
    } else {
      throw Exception('No location found for the given postal code.');
    }
  } catch (error) {
    throw Exception('Error occurred while retrieving location: $error');
  }
});
