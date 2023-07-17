import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  Future<void> getStores() async {
    try {

      final pref = await SharedPreferences.getInstance();

      final userId = pref.getUserId();
      final Users? user = await _getUser(userId);
      debugPrint("$user");
      final hasUserZipCodeField = user?.zipCode.isNotEmpty ?? false;

      // final storesCollection = _fireStore.collection('stores');

      List<Stores> stores = [];
      state = ApiResponse.loading();

      debugPrint("${user?.zipCode}");



      if (hasUserZipCodeField) {
        stores = await _fetchProductsByZipCode(user?.zipCode ?? "");
        debugPrint("$stores");
      } else {
        /*final querySnapshot = await storesCollection
            .where('location',
                isGreaterThan: GeoPoint(user?.latitude - 0.1,
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

        print('Received data: ${stores[0].name}');*/
      }

      state = ApiResponse.success(data: stores);
    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
    }
  }

  Future<List<Stores>> _fetchProductsByZipCode(String userZipCode) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('stores')
          .where('zipCodesList', arrayContains: userZipCode)
          .get();

      final List<Stores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = Stores.fromJson(data);
        return store;
      }).toList();

      return stores;
    } catch (error) {
      return [];
    }
  }

  Future<Users?> _getUser(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('users')
          .where('uid', isEqualTo: userId)
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

  Future<bool> _hasUserZipCodeField(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        return userData.containsKey('zipCode');
      }

      return false;
    } catch (error) {
      return false;
    }
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
