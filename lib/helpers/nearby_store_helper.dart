import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/utils/spenza_extensions.dart';

mixin NearbyStoreMixin {
  Future<List<Stores>> getNearbyStores(
      {required var firestore,
      required var userLocation,
      double radius = 3}) async {
    try {
      // Create a GeoFirePoint for "User Location"
      GeoFirePoint center = GeoFirePoint(userLocation);

      // Reference to locations collection.
      final CollectionReference<Map<String, dynamic>> locationCollectionRef =
          firestore.collection('stores');

      // Get the documents within a 3 km radius of "Akota Garden"
      final result =
          await GeoCollectionReference(locationCollectionRef).fetchWithin(
        center: center,
        radiusInKm: radius,
        // todo make it dynamic via constant
        field: 'geo',
        strictMode: true,
        geopointFrom: geopointFrom,
      );

      final List<Stores> stores = [];

      for (var value in result) {
        /*String storeId= value.id;
        final distance =
            center.distanceBetweenInKm(geopoint: value['location']);
        print("StoreName : $storeId == Distance : $distance");*/

        stores.add(Stores(
          id: value.id,
          name: value['name'],
          adress: value['address'],
          zipCodesList: [],
          logo: value['logo'],
        ));
      }

      return stores;
    } catch (e) {
      print("ERROR IN LOCATION : $e");
      throw new NearbyStoreException('Firebase Exception', e);
    }
  }

  Future<double> getDistanceFromLocation(
      {required GeoPoint userLocation,
      required GeoPoint destinationLocation}) async {
    try {
      // Create a GeoFirePoint for "User Location"
      GeoFirePoint center = GeoFirePoint(userLocation);

      final distance =
          center.distanceBetweenInKm(geopoint: destinationLocation);

      return distance;
    } catch (e) {
      print("ERROR IN Distance : $e");
      return 0;
    }
  }
}

class NearbyStoreException implements Exception {
  final String message;
  final dynamic error;

  NearbyStoreException(this.message, this.error);

  @override
  String toString() {
    return 'CustomException: $message, $error';
  }
}
