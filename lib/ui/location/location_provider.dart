import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/location/repo/location_repo.dart';
import 'package:spenza/ui/location/state/location_state.dart';


final locationPermissionProvider =
    StateNotifierProvider<LocationRepository, LocationState>(
  (ref) {
    return LocationRepository();
  },
);
