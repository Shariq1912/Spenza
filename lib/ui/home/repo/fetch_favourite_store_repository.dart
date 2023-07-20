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
      final snapshot = await FirebaseFirestore.instance
          .collection(FavoriteConstant.favoriteCollection)
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/$userId')
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
      print("Error fetching favorite stores: $error");
      return [];
    }
  }

}