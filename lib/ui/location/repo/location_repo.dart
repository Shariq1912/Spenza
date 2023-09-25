import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/location/state/location_state.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../../utils/fireStore_constants.dart';

class LocationRepository extends StateNotifier<LocationState> {
  LocationRepository() : super(const LocationState());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> requestLocationPermission() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = LocationState.error(message: "Location service is disabled");
      }

      state = LocationState.loading();

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      /// will display ZipCode Screen
      if (permission == LocationPermission.denied) {
        state = const LocationState.denied();
        return;
      }

      /// Permission Granted
      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _saveLocationToServer(
        latitude: initialPosition.latitude,
        longitude: initialPosition.longitude,
      );

      await _saveZipCodeToServer(await _getPostalCode(initialPosition));

      state = LocationState.success(
          message: 'Coordinates and zipcode saved successfully');
    } catch (error) {
      /// Error but can managed by showing zipcode dialog.
      // state = LocationState.error(message: error.toString());
      debugPrint("$error");
      state = LocationState.denied();
    }
  }

  /// Called when user enters zip code manually
  /// Stores Location and Zip code to the user collection
  Future<void> processZipCodeEnteredByUser(String postalCode) async {
    try {
      state = LocationState.loading();
      List<Location> locations = await locationFromAddress(postalCode);
      if (locations.isNotEmpty) {
        final latitude = locations.first.latitude;
        final longitude = locations.first.longitude;

        await _saveZipCodeToServer(postalCode);
        await _saveLocationToServer(
          latitude: latitude,
          longitude: longitude,
        );

        state = LocationState.success(
          message: 'Coordinates retrieved successfully',
        );
      } else {
        /// Even if location not found we can store zip code.
        await _saveZipCodeToServer(postalCode);
        debugPrint("No location found for the given postal code");
        state = LocationState.error(
          message: 'No location found for the given postal code',
        );
      }
    } catch (error) {
      /// Even if location not found we can store zip code.
      await _saveZipCodeToServer(postalCode);
      debugPrint("$error");
      state = LocationState.error(
        message: 'Error occurred while retrieving location: $error',
      );
    }
  }

  Future<String> _getPostalCode(Position position) async {
    String postalCode = "";

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      postalCode = placemarks.first.postalCode ?? "";
      debugPrint('Postal Code: $postalCode');
    } catch (e) {
      debugPrint('Error: $e');
    }

    return postalCode;
  }

  Future<void> _saveLocationToServer({
    required double latitude,
    required double longitude,
  }) async {
    /// Due to State notifier not accepting Future temporary solution

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _fireStore.collection('users').doc(prefs.getUserId()).set(
      {
        'location': GeoPoint(latitude, longitude),
      },SetOptions(merge: true)
    );
  }

  Future<void> redirectUserToDestination({
    required BuildContext context,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isFirstTimeLogin = prefs.isFirstLogin();

    if (!isFirstTimeLogin) {
      context.goNamed(RouteManager.homeScreen);
      return;
    }
    context.goNamed(RouteManager.favouriteScreen);
  }

  Future<void> _saveZipCodeToServer(String postalCode) async {
    /// Due to State notifier not accepting Future temporary solution
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(UserConstant.zipCodeField, postalCode);
    await _fireStore.collection('users').doc(prefs.getUserId()).set(
      {
        'zipCode': postalCode,
      },SetOptions(merge: true)
    );
  }
  Future<void> requestLocationPermissionUsingDialog() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = LocationState.error(message: "Location service is disabled");
        return;
      }

      state = LocationState.loading();

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        permission = await Geolocator.checkPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        state = LocationState.denied();
        return;
      }

      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _saveLocationToServer(
        latitude: initialPosition.latitude,
        longitude: initialPosition.longitude,
      );

      await _saveZipCodeToServer(await _getPostalCode(initialPosition));

      state = LocationState.success(
          message: 'Coordinates and zipcode saved successfully');
    } catch (error) {
      debugPrint("$error");
      state = LocationState.denied();
    }
  }



}
