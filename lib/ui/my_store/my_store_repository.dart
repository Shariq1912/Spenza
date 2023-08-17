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
          //    isEqualTo: 'users/rbUVwnV1rpcTAOGyTv0ZyMDANsM2')
          isEqualTo: 'users/$userId')
          .get();

      final List<FetchFavouriteStores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = FetchFavouriteStores.fromJson(data).copyWith(documentId: doc.id);
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



  Future<List<AllStores>> fetchFavStore(List<FetchFavouriteStores> stores) async {
    if (stores.isNotEmpty) {
      final List allStoreReferences = stores
          .expand((store) => store.store_ids.map((ref) => _fireStore.doc(ref)))
          .toList();

      final int batchSize = 10;

      List<List<DocumentReference>> batches = [];
      for (int i = 0; i < allStoreReferences.length; i += batchSize) {
        int end = i + batchSize;
        if (end > allStoreReferences.length) {
          end = allStoreReferences.length;
        }
        batches.add(allStoreReferences.sublist(i, end).cast<DocumentReference>());

      }

      List<QuerySnapshot<Map<String, dynamic>>> snapshots = [];

      for (var batch in batches) {
        final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
            .collection('stores')
            .where(FieldPath.documentId, whereIn: batch.map((ref) => ref.id).toList())
            .get();
        snapshots.add(snapshot);
      }

      final List<AllStores> favoriteStoreDetails = [];
      for (var snapshot in snapshots) {
        favoriteStoreDetails.addAll(snapshot.docs.map((document) => AllStores.fromJson(document.data())));
      }

      return favoriteStoreDetails;
    } else {
      return [];
    }
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

      List<AllStores> favouriteAllStores = await fetchAndDisplayFavouriteStores();
      List<AllStores> allStores = snapshot.docs.map((doc) {
        final data = doc.data();
        final allStore = AllStores.fromJson(data).copyWith(documentId: doc.id);
        return allStore;
      }).toList();

      if (favouriteAllStores.isEmpty) {
        List<AllStores> regularStores = allStores;
        state = ApiResponse.success(data: regularStores);
        return regularStores;
      }
      else{
        List<AllStores> storesWithSameName = [];
        List<AllStores> storesWithdifferentName = [];
        Set<String> favouriteStoreNames = favouriteAllStores.map((store) => store.name).toSet();
        for (var store in allStores) {
          if (favouriteStoreNames.contains(store.name)) {
            print("samme : ${store.name}");
            storesWithSameName.add(store);
          }
          else{
            storesWithdifferentName.add(store);
          }
        }
        List<AllStores> favMarked = storesWithSameName.map((e)  {
          return e.copyWith(isFavorite:true);
        }).toList();

        favMarked.forEach((element) {
          print("samme :${element.documentId}");
        });


        List<AllStores> allStoresInclFav = [...favMarked, ...storesWithdifferentName];
        state = ApiResponse.success(data: allStoresInclFav);
        return allStoresInclFav;
      }

    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }

  /*Future<void> toggleFavoriteStore(AllStores store) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    final storeReference = 'stores/${store.documentId}';

    try {
      final snapshot = await _fireStore
          .collection(FavoriteConstant.favoriteCollection)
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/$userId')
          .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id;
        final currentStores = snapshot.docs.first.data()[FavoriteConstant.storeIdsField] as List;
        final isFavorite = currentStores.contains(storeReference);

        if (isFavorite) {
          currentStores.remove(storeReference);
        } else {
          currentStores.add(storeReference);
        }

        await _fireStore.collection(FavoriteConstant.favoriteCollection).doc(docId).update({
          FavoriteConstant.storeIdsField: currentStores,
        });
      } else {
        await _fireStore.collection(FavoriteConstant.favoriteCollection).add({
          FavoriteConstant.userIdField: 'users/$userId',
          FavoriteConstant.storeIdsField: [storeReference],
        });
      }

      await fetchAllStores();
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      print("Error toggling favorite store: $error");
    }
  }*/

  Future<void> toggleFavoriteStore(AllStores store) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    final storeReference = 'stores/${store.documentId}';
    final favoriteCollection = FirebaseFirestore.instance.collection(FavoriteConstant.favoriteCollection);

    try {
      final querySnapshot = await favoriteCollection
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/$userId')
          .get();

      final batch = FirebaseFirestore.instance.batch();

      if (querySnapshot.docs.isNotEmpty) {
        final favoriteDoc = querySnapshot.docs.first;
        final currentStores = favoriteDoc.data()[FavoriteConstant.storeIdsField] as List;

        if (currentStores.contains(storeReference)) {
          currentStores.remove(storeReference);
        } else {
          currentStores.add(storeReference);
        }

        batch.update(favoriteDoc.reference, {
          FavoriteConstant.storeIdsField: currentStores,
        });
      } else {
        final newFavoriteDocRef = favoriteCollection.doc();
        batch.set(newFavoriteDocRef, {
          FavoriteConstant.userIdField: 'users/$userId',
          FavoriteConstant.storeIdsField: [storeReference],
        });
      }

      await batch.commit();
      //await fetchAllStores();
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      print("Error toggling favorite store: $error");
    }
  }





}
