import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
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
          .where(FavoriteConstant.userIdField,
              isEqualTo: 'users/rbUVwnV1rpcTAOGyTv0ZyMDANsM2')
          //isEqualTo: 'users/$userId')
          .get();

      final List<FetchFavouriteStores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = FetchFavouriteStores.fromJson(data);
        print("FVTT ${store.store_ids}");
        return store;
      }).toList();

      print("FVTTs ${stores.length}");
      if (stores.isEmpty) {
        return [];
      }

      return stores;
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      print("Error fetching favorite stores: $error");
      return [];
    }
  }

  Future<List<AllStores>> fetchFavStore(
      List<FetchFavouriteStores> stores) async {
    if (stores.isNotEmpty) {
      final List allStoreReferences = stores
          .expand((store) => store.store_ids.map((ref) => _fireStore.doc(ref)))
          .toList();

      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('stores')
          .where(
            FieldPath.documentId,
            whereIn: allStoreReferences.map((ref) => ref.id).toList(),
          )
          .get();

      final List<AllStores> favoriteStoreDetails = snapshot.docs
          .map((document) => AllStores.fromJson(document.data()))
          .toList();

      return favoriteStoreDetails;
    } else
      return [];
  }

  Future<List<AllStores>> fetchAndDisplayFavouriteStores() async {
    final List<FetchFavouriteStores> favouriteStores =
        await fetchFavouriteStores();
    final List<AllStores> allFavouriteStores =
        await fetchFavStore(favouriteStores);
    if (allFavouriteStores.isNotEmpty) {
      allFavouriteStores.forEach((store) {
        print("Favorite Store Name: ${store.name}");
      });
      state = ApiResponse.success(data: allFavouriteStores);
      return allFavouriteStores;
    } else {
      return [];
    }
  }

  Future<List<AllStores>> fetchAllStores() async {
    state = ApiResponse.loading();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _fireStore.collection('stores').get();

      List<AllStores> favouriteAllStores =
          await fetchAndDisplayFavouriteStores();
      List<AllStores> allStores = snapshot.docs.map((doc) {
        final data = doc.data();
        final allStore = AllStores.fromJson(data);
        return allStore;
      }).toList();

      if (favouriteAllStores.isEmpty) {
        List<AllStores> regularStores = allStores;
        state = ApiResponse.success(data: regularStores);
        return regularStores;
      } else {
        List<AllStores> updatedFavouriteAllStores =
            favouriteAllStores.map((store) {
          return store.copyWith(isFavorite: true);
        }).toList();

        List<AllStores> favoriteStores = updatedFavouriteAllStores
            .where((store) => store.isFavorite)
            .toList();
        List<AllStores> regularStores = allStores.where((store) => !store.isFavorite).toList();

        List<AllStores> allStoresInclFav = [...favoriteStores, ...regularStores];

        state = ApiResponse.success(data: allStoresInclFav);

        allStoresInclFav.forEach((element) {
          print("listelement : ${element.name}");
        });

        return allStoresInclFav;
      }
    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }
}
