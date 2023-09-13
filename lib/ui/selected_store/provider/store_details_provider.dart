import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/utils/firestore_constants.dart';

part 'store_details_provider.g.dart';

@riverpod
class StoreDetails extends _$StoreDetails with FirestoreAndPrefsMixin {
  @override
  Future<Stores> build() async {
    return Stores(name: "", address: "address", zipCodesList: [], logo: "");
  }

  Future<void> getSelectedStore({required DocumentReference storeRef}) async {
    final DocumentSnapshot<Object?> storeSnapshot = await storeRef.get();

    final store = Stores(
        id: storeSnapshot.id,
        name: storeSnapshot['name'],
        groupName: storeSnapshot['groupName'],
        address: "",
        zipCodesList: [],
        logo: storeSnapshot['logo']);

    state = AsyncValue.data(store);
  }

  Future<void> getSelectedStoreFromStoreId({required String storeId}) async {

    final DocumentReference storeRef = fireStore.collection(StoreConstant.storeCollection).doc(storeId);
    final DocumentSnapshot<Object?> storeSnapshot = await storeRef.get();

    final store = Stores(
        id: storeSnapshot.id,
        name: storeSnapshot['name'],
        groupName: storeSnapshot['groupName'],
        address: "",
        zipCodesList: [],
        logo: storeSnapshot['logo']);

    state = AsyncValue.data(store);
  }
}
