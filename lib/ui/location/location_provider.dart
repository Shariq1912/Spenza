import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

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

  const LocationSettings locationSettings =
      LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
  Position initialPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return initialPosition;
});
