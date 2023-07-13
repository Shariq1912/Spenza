import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/spenza_extensions.dart';

final positionProvider = FutureProvider.autoDispose<Position?>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return throw Exception("Location service is disabled");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return throw Exception("Location service is denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return throw Exception("Location service is deniedForever");
  }

  Position initialPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  final pref = await SharedPreferences.getInstance();
  await FirebaseFirestore.instance.collection('users').doc(pref.getUserId()).set(
    {
      'location': GeoPoint(initialPosition.latitude, initialPosition.longitude),
    },
    SetOptions(merge: true),
  );

  return initialPosition;
});
