import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/firestore_constants.dart';

extension ImageExtension on String {
  String get assetImageUrl {
    return 'assets/images/$this';
  }
}

extension SnackbarExtension on BuildContext {
  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  String getUserId() {
    return getString('uid')!;
  }

  bool isUserLoggedIn() {
    return getBool('is_login') ?? false;
  }

  bool isFirstLogin() {
    return getBool('is_first_login') ?? true;
  }
}

extension NumberFormat on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension LocationStringExtension on GeoPoint {
  String getLocationString() {
    String latitude = this.latitude.toString();
    String longitude = this.longitude.toString();
    return "($latitude, $longitude)";
  }
}

extension FirestoreExtension on FirebaseFirestore {
  DocumentReference getDocumentReferenceFromString({required String collectionName,required String id}) {
    return this.collection(collectionName).doc(id);
  }

}

mixin FirstTimeLoginMixin {
  Future<bool> isFirstTimeLogin(
      {required FirebaseFirestore firestore, required String userId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(UserConstant.userCollection)
          .where(UserConstant.userIdField, isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        debugPrint("IS FIRST LOGIN === $userData");
        return !(userData.containsKey(UserConstant.zipCodeField) &&
            userData[UserConstant.zipCodeField] != "");
      }

      return false;
    } catch (error) {
      return false;
    }
  }
}

/// Not much accurate
double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
    ) {
  const int earthRadius = 6371; // in km
  final double dLat = _toRadians(lat2 - lat1);
  final double dLon = _toRadians(lon2 - lon1);
  final double a = pow(sin(dLat / 2), 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          pow(sin(dLon / 2), 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c;
  return distance;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

// Function to get GeoPoint instance from Cloud Firestore document data.
GeoPoint geopointFrom(Map<String, dynamic> data) =>
    (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint;


