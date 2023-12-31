import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/home/data/fetch_favourite_store.dart';
import 'package:spenza/ui/home/data/fetch_favourite_store_state.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../my_store/data/all_store.dart';

part 'fetch_favourite_store_repository.g.dart';
/*

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
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/$userId')
          .get();

      final List<FetchFavouriteStores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = FetchFavouriteStores.fromJson(data);
        print("FVTT ${store.store_ids}");
        return store;
      }).toList();

      print("FVTTs ${stores.length}");
      if(stores.isEmpty){
        return [];
      }
      return stores;

    } catch (error) {
      state = FetchFavouriteStoreState.error(message: error.toString());
      print("Error fetching favorite stores: $error");
      return [];
    }
  }

  Future<List<AllStores>> fetchAllStores(List<FetchFavouriteStores> stores) async {
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
    state= FetchFavouriteStoreState.loading();
    final List<FetchFavouriteStores> favouriteStores = await fetchFavouriteStores();
    final List<AllStores> allFavouriteStores = await fetchAllStores(favouriteStores);

    if(allFavouriteStores.isNotEmpty){

    allFavouriteStores.forEach((store) {
      print("Favorite Store Name: ${store.name}");
    });
    state = FetchFavouriteStoreState.success(data: allFavouriteStores);
    return allFavouriteStores;

    }
    else{
      state= FetchFavouriteStoreState.empty(message: "no store found");
      return [];
    }
      
  }
*/
/*
  Future<List<AllStores>> fetchFavStores() async {
    state = FetchFavouriteStoreState.loading();
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
        state = FetchFavouriteStoreState.success(data: regularStores);
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
        state = FetchFavouriteStoreState.success(data: favMarked);
        return favMarked;
      }

    } catch (error) {
      state = FetchFavouriteStoreState.error(
        message: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }*//*


  Future<List<AllStores>> fetchFavStores() async {
    state = FetchFavouriteStoreState.loading();
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
        // Create a new list
        List<AllStores> regularStores = List.from(allStores);
        state = FetchFavouriteStoreState.success(data: regularStores);
        return regularStores;
      } else {
        List<AllStores> storesWithSameName = [];
        List<AllStores> storesWithdifferentName = [];
        Set<String> favouriteStoreNames =
        favouriteAllStores.map((store) => store.name).toSet();
        for (var store in allStores) {
          if (favouriteStoreNames.contains(store.name)) {
            print("samme : ${store.name}");
            storesWithSameName.add(store);
          } else {
            storesWithdifferentName.add(store);
          }
        }
        List<AllStores> favMarked = storesWithSameName.map((e) {
          return e.copyWith(isFavorite: true);
        }).toList();

        favMarked.forEach((element) {
          print("samme :${element.documentId}");
        });

        List<AllStores> allStoresInclFav = [...favMarked, ...storesWithdifferentName];
        state = FetchFavouriteStoreState.success(data: favMarked);
        return favMarked;
      }
    } catch (error) {
      state = FetchFavouriteStoreState.error(
        message: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }


}*/

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
          .where(FavoriteConstant.userIdField, isEqualTo: 'users/$userId')
          .get();

      final List<FetchFavouriteStores> stores = snapshot.docs.map((doc) {
        final data = doc.data();
        final store = FetchFavouriteStores.fromJson(data);
        print("FVTT ${store.store_ids}");
        return store;
      }).toList();

      print("FVTTs ${stores.length}");
      if(stores.isEmpty){
        return [];
      }
      return stores;

    } catch (error) {
      state = FetchFavouriteStoreState.error(message: error.toString());
      print("Error fetching favorite stores: $error");
      return [];
    }
  }

  Future<List<AllStores>> fetchAllStores(List<FetchFavouriteStores> stores) async {
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

  // Fetch and display favorite stores, handling different states
  Future<List<AllStores>> fetchAndDisplayFavouriteStores() async {
    state= FetchFavouriteStoreState.loading();
    final List<FetchFavouriteStores> favouriteStores = await fetchFavouriteStores();
    final List<AllStores> allFavouriteStores = await fetchAllStores(favouriteStores);

    if(allFavouriteStores.isNotEmpty){
      allFavouriteStores.forEach((store) {
        print("Favorite Store Name: ${store.name}");
      });
      state = FetchFavouriteStoreState.success(data: allFavouriteStores);
      return allFavouriteStores;
    }
    else{
      state= FetchFavouriteStoreState.empty(message: "no store found");
      return [];
    }
  }


  Future<List<AllStores>> fetchFavStores() async {
    state = FetchFavouriteStoreState.loading();
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

        List<AllStores> regularStores = List.from(allStores);
        state = FetchFavouriteStoreState.success(data: []);
        return [];
      } else {
        List<AllStores> storesWithSameName = [];
        List<AllStores> storesWithdifferentName = [];
        Set<String> favouriteStoreNames =
        favouriteAllStores.map((store) => store.name).toSet();
        for (var store in allStores) {
          if (favouriteStoreNames.contains(store.name)) {
            print("samme : ${store.documentId}");
            storesWithSameName.add(store);
          } else {
            storesWithdifferentName.add(store);
          }
        }
        List<AllStores> favMarked = storesWithSameName.map((e) {
          return e.copyWith(isFavorite: true);
        }).toList();

        favMarked.forEach((element) {
          print("samme :${element.documentId}");
        });
        if(favMarked.isEmpty){
          state = FetchFavouriteStoreState.success(data: favMarked);
          return [];
        }

       // List<AllStores> allStoresInclFav = [...favMarked, ...storesWithdifferentName];
        state = FetchFavouriteStoreState.success(data: favMarked);
        return favMarked;
      }
    } catch (error) {
      state = FetchFavouriteStoreState.error(
        message: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }
}
