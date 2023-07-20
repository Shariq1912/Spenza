import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/home/repo/fetch_favourite_store_repository.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../utils/firestore_constants.dart';
import '../home/data/fetch_favourite_store.dart';
class MyStoreRepository extends StateNotifier<ApiResponse> {
  MyStoreRepository() : super(const ApiResponse());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<FetchFavouriteStores>> fetchFavouriteStores() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();

    try {
      final snapshot = await _fireStore
          .collection(FavoriteConstant.favoriteCollection)
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/rbUVwnV1rpcTAOGyTv0ZyMDANsM2')
          .get();

      final List<FetchFavouriteStores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = FetchFavouriteStores.fromJson(data);
        print("FVTT ${store.store_ids}");
        return store;
      }).toList();

      print("FVTTs ${stores.length}");
      return stores;

    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      print("Error fetching favorite stores: $error");
      return [];
    }
  }
  Future<List<AllStores>> fetchFavStore(List<FetchFavouriteStores> stores) async {
    final List allStoreReferences = stores
        .expand((store) => store.store_ids.map((ref) => _fireStore.doc(ref)))
        .toList();

    final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
        .collection('stores')
        .where(
      FieldPath.documentId,
      whereIn: allStoreReferences.map((ref) => ref.id).toList(),
    ).get();

    final List<AllStores> favoriteStoreDetails = snapshot.docs
        .map((document) => AllStores.fromJson(document.data())).toList();

    return favoriteStoreDetails;
  }

  Future<List<AllStores>> fetchAndDisplayFavouriteStores() async {

    final List<FetchFavouriteStores> favouriteStores = await fetchFavouriteStores();
    final List<AllStores> allFavouriteStores = await fetchFavStore(favouriteStores);

    allFavouriteStores.forEach((store) {
      print("Favorite Store Name: ${store.name}");
    });

    return allFavouriteStores;
  }

  Future<List<AllStores>> fetchAllStores() async {
    state = ApiResponse.loading();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _fireStore.collection('stores').get();

      List<AllStores> allStoresInclFav = [];

      final List<AllStores> favouriteAllStores = await fetchAndDisplayFavouriteStores();
      allStoresInclFav.addAll(favouriteAllStores);

      List<AllStores> allStores = snapshot.docs.map((doc) {
        final data = doc.data();
        final allStore = AllStores.fromJson(data);
        return allStore;
      }).toList();
      print(" allStoreLength ${allStores.length}");
      allStores.forEach((element) {
        print(" allStoresItems ${element.name}");
      });
      allStoresInclFav.addAll(allStores);
      state = ApiResponse.success(data: allStoresInclFav);

      return allStoresInclFav;

    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }
/*
  Future<List<AllStores>> fetchAllStores() async {
    state = ApiResponse.loading();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _fireStore.collection('stores').get();

      List<AllStores> favouriteAllStores = await fetchAndDisplayFavouriteStores();
      List<AllStores> allStores = snapshot.docs.map((doc) {
        final data = doc.data();
        final allStore = AllStores.fromJson(data);
        return allStore;
      }).toList();

      // Create a map to store favorite stores using store ID as the key
      final Map<String, AllStores> favoriteStoresMap = {};
      for (var favoriteStore in favouriteAllStores) {
        favoriteStoresMap[favoriteStore.id] = favoriteStore;
      }

      // Mark the favorite stores as favorites in the allStores list
      for (var store in allStores) {
        if (favoriteStoresMap.containsKey(store.id)) {
          store.isFavorite = true;
        }
      }

      List<AllStores> allStoresInclFav = allStores;

      // ... Rest of the code remains unchanged

      state = ApiResponse.success(data: allStoresInclFav);
      return allStoresInclFav;

    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }*/

}