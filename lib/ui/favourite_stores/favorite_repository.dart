import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_store_state.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores_request.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'data/favourite_stores.dart';

class FavoriteRepository extends StateNotifier<FavouriteStoreState> {
  FavoriteRepository() : super(const FavouriteStoreState());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<Stores> _favoriteStores = [];

  getStores() async {
    try {
      final pref = await SharedPreferences.getInstance();

      final userId = pref.getUserId();
      final Users? user = await _getUser(userId);
      debugPrint("$user");
      final hasUserZipCodeField = user?.zipCode.isNotEmpty ?? false;

      // final storesCollection = _fireStore.collection('stores');

      state = FavouriteStoreState.loading();

      List<Stores> stores = [];

      debugPrint("${user?.zipCode}");

      if (hasUserZipCodeField) {
        debugPrint("Inside If");
        stores = await _fetchProductsByZipCode(user?.zipCode ?? "");
        // debugPrint("Stores From ZIP CODE are ==== $stores");
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

      debugPrint("Setting up the State");
      state = FavouriteStoreState.success(data: stores);
    } catch (error) {
      debugPrint("ERROR IS === $error");
      state = FavouriteStoreState.error(
        message: 'Error occurred while fetching stores: $error',
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

        final store = Stores.fromJson(data).copyWith(id: doc.id);
        // final store = Stores.fromJson(data);
        // Get the document ID and print it to the console
        // debugPrint('Store is :::: $store');

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
    debugPrint("Called toggle Favourite on $store");
    FavouriteStoreState updatedStores = state.maybeWhen(
      () => state,
      success: (stores) {
        final updatedList = stores.map((Stores s) {
          if (s.id == store.id) {
            /// User toggled and already favorite then remove from favorite
            s.isFavorite
                ? _favoriteStores.remove(store)
                : _favoriteStores.add(store);

            return s.copyWith(isFavorite: !s.isFavorite);
          } else {
            return s;
          }
        }).toList();
        return FavouriteStoreState.success(data: updatedList);
      },
      orElse: () => state,
    );

    state = updatedStores;
  }

  Future<void> saveFavouriteStoreIfAny() async {
    try {
      if (_favoriteStores.isEmpty) {
        /// Redirect user to home screen
        state = FavouriteStoreState.redirectUser();
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      final favouriteStoresCollection = _fireStore.collection('favorites');

      final favouriteStoresRequest = FavouriteStoresRequest(
        userId: "users/$userId",
        storeIds:
            _favoriteStores.map((Stores data) => "stores/${data.id}").toList(),
      );

      final favouriteStoresData = favouriteStoresRequest.toJson();
      debugPrint("FAVOURITE STORES  ==== $favouriteStoresData");

      await favouriteStoresCollection.add(favouriteStoresData);
      state = FavouriteStoreState.redirectUser();

      /// Redirect user to home screen
    } catch (error) {
      state = FavouriteStoreState.error(message: error.toString());
    }
  }
}
