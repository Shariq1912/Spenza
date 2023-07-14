import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'data/favourite_stores.dart';

class FavoriteRepository extends StateNotifier<ApiResponse> {
  FavoriteRepository() : super(const ApiResponse());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> fetchNearbyStores() async {
    final pref = await SharedPreferences.getInstance();
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(pref.getUserId())
        .get();

    GeoPoint location = document.data()!['location'];

    /*final geo = GeoFlutterFire();
    // Create a GeoFirePoint from the provided latitude and longitude
    GeoFirePoint center =
        // geo.point(latitude: location.latitude, longitude: location.longitude);
        geo.point(latitude: 20.72287011, longitude: -103.415378);
    // 20.72287011, -103.415378

    // Get the Firestore CollectionReference for the "stores" collection
    final collectionRef = FirebaseFirestore.instance.collection('stores');

    // Fetch nearby stores using the "location" field and provided radius
    List<DocumentSnapshot> nearbyStores = await geo
        .collection(collectionRef: collectionRef)
        .within(
          center: center,
          radius: 5000,
          field: 'location',
        )
        .first;

    debugPrint("Favourite data is $nearbyStores");*/

    final collectionRef = FirebaseFirestore.instance.collection('stores');

// Get all documents in the "stores" collection.
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Iterate over the documents and print their fields.
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      debugPrint("Document: ${documentSnapshot.id}");
      debugPrint(documentSnapshot.data() as String?);
    }

    // state = ApiResponse.success(data: collectionRef);

    return [];
    // return nearbyStores;
  }

  Future<void> fetchProductsByZipCode(String userZipCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection('stores')
        .where('zipCodesList', arrayContains: userZipCode)
        .get();

    final List<Stores> stores = snapshot.docs.map((doc) {
      final data = doc.data();
      final store = Stores.fromJson(data);
      print(store.name); // Print store name
      return store;
    }).toList();

    state = ApiResponse.success(data: stores);
  }

  void toggleFavorite(Stores store) {
    final updatedStores = state.maybeWhen(
      () => state,
      success: (stores) {
        final updatedList = stores.map((s) {
          if (s.name == store.name) {
            return s.copyWith(isFavorite: !s.isFavorite);
          } else {
            return s;
          }
        }).toList();
        return ApiResponse.success(data: updatedList);
      },
      orElse: () => state,
    );

    state = updatedStores;
  }

  Future<List<Stores>?> fetchProductsByZipCode2(String userZipCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('stores')
        .where('zipCodesList', arrayContains: userZipCode)
        .get();

    final List<Stores> stores = snapshot.docs.map((doc) {
      final data = doc.data();
      final store = Stores.fromJson(data);
      print(store.name); // Print store name
      return store;
    }).toList();

    return stores;
  }
}
