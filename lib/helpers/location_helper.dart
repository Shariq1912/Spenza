import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:spenza/utils/fireStore_constants.dart';

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

  Future<String> getUserZipCodeFromDB(
      FirebaseFirestore fireStore, String userId) async {
    try {
      final Users? user = await _getUser(fireStore, userId);
      return user?.zipCode ?? "45116";
    } catch (error) {
      debugPrint("$error");
      return "45116";
    }
  }

  Future<Users?> _getUser(FirebaseFirestore fireStore, String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore
          .collection(UserConstant.userCollection)
          .where(UserConstant.userIdField, isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        return Users.fromJson(userData);
      }

      return null;
    } catch (error) {
      return null;
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
