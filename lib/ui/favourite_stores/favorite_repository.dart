import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spenza/network/api_responses.dart';
import 'data/favourite_stores.dart';

class FavoriteRepository extends StateNotifier<ApiResponse> {
  FavoriteRepository() : super(const ApiResponse());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
/*
  Future<List<DocumentSnapshot>> fetchNearbyStores() async {
    final pref = await SharedPreferences.getInstance();
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(pref.getUserId())
        .get();

    GeoPoint location = document.data()!['location'];


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
  }*/

  Future<void> fetchProductsByZipCode(String userZipCode) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection('stores')
        .where('zipCodesList', arrayContains: userZipCode)
        .get();

    final List<Stores> stores = snapshot.docs.map((doc) {
      final data = doc.data();
      final store = Stores.fromJson(data);
      //print(store.name); // Print store name
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


  Future<void> getStores(Position currentPosition) async {
    final storesCollection = _fireStore.collection('stores');

    final querySnapshot = await storesCollection
        .where('location',
            isGreaterThan: GeoPoint(currentPosition.latitude - 0.1,
                currentPosition.longitude - 0.1),
            isLessThan: GeoPoint(currentPosition.latitude + 0.1,
                currentPosition.longitude + 0.1))
        .get();

    final documents = querySnapshot.docs;
    final List<Stores> stores = documents.map((doc) {
      final data = doc.data();
      final store = Stores.fromJson(data);
      return store;
    }).toList();

    print('Received data: ${stores[0].name}');

    state = ApiResponse.success(data: stores);
  }
}
