import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'data/favourite_stores.dart';

class FavoriteRepository extends StateNotifier<ApiResponse> {
  FavoriteRepository() : super(const ApiResponse());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<Stores>> fetchProductsByZipCode(String userZipCode) async {
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
    return stores;
  }

  Future<bool> _hasUserZipCodeField(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection('users')
        .where('uid', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.first.data();
      return userData.containsKey('zipCode');
    }

    return false;
  }

  Future<void> getStores(Position currentPosition) async {
    final pref = await SharedPreferences.getInstance();

    final userId = pref.getUserId();
    final hasUserZipCodeField = await _hasUserZipCodeField(userId);

    final storesCollection = _fireStore.collection('stores');

    List<Stores> stores = [];

    if (!hasUserZipCodeField) {
      final querySnapshot = await storesCollection
          .where('location',
              isGreaterThan: GeoPoint(currentPosition.latitude - 0.1,
                  currentPosition.longitude - 0.1),
              isLessThan: GeoPoint(currentPosition.latitude + 0.1,
                  currentPosition.longitude + 0.1))
          .get();

      final documents = querySnapshot.docs;
      stores = documents.map((doc) {
        final data = doc.data();
        final store = Stores.fromJson(data);
        return store;
      }).toList();

      print('Received data: ${stores[0].name}');
    } else {
      final user = await getUser(userId);
      stores = await fetchProductsByZipCode(user?.zipCode ?? "");
    }

    state = ApiResponse.success(data: stores);
  }

  Future<Users?> getUser(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.first.data();
      return Users.fromJson(userData);
    }

    return null;
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
}
