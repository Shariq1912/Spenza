import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

mixin LocationHelper {
  Future<GeoPoint?> getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((value) => GeoPoint(value.latitude, value.longitude));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GeoPoint> getLocationByZipCode(String postalCode) async {
    try {
      List<Location> locations = await locationFromAddress(postalCode);
      if (locations.isNotEmpty) {
        final latitude = locations.first.latitude;
        final longitude = locations.first.longitude;

        return GeoPoint(latitude, longitude);
      } else {
        return GeoPoint(20.68016662, -103.3822084);
      }
    } catch (error) {
      /// Even if location not found we can store zip code.
      /// Soriana City Center = 20.68016662, -103.3822084
      debugPrint("Location by Zip code error == $error");
      return GeoPoint(20.68016662, -103.3822084);
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled. Please enable the services');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }
}
