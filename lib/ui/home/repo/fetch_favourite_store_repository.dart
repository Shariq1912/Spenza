import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/home/data/fetch_favourite_store.dart';
import 'package:spenza/ui/home/data/fetch_favourite_store_state.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../my_store/data/all_store.dart';

part 'fetch_favourite_store_repository.g.dart';

@riverpod
class FetchFavouriteStoreRepository extends _$FetchFavouriteStoreRepository {

  @override
  FetchFavouriteStoreState build() {
    return FetchFavouriteStoreState();
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<FetchFavouriteStores> _favoriteStores = [];

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
      state = FetchFavouriteStoreState.error(message: error.toString());
      print("Error fetching favorite stores: $error");
      return [];
    }
  }
  Future<List<AllStores>> fetchAllStores(List<FetchFavouriteStores> stores) async {
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
    state= FetchFavouriteStoreState.loading();
    final List<FetchFavouriteStores> favouriteStores = await fetchFavouriteStores();
    final List<AllStores> allFavouriteStores = await fetchAllStores(favouriteStores);

    allFavouriteStores.forEach((store) {
      print("Favorite Store Name: ${store.name}");
    });
    state = FetchFavouriteStoreState.success(data: allFavouriteStores);
    return allFavouriteStores;
  }
}