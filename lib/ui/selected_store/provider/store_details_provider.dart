import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/selected_store/data/selected_product.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'package:collection/collection.dart';

part 'store_details_provider.g.dart';

@riverpod
class StoreDetails extends _$StoreDetails {
  @override
  Future<Stores> build() async {
    return Stores(name: "", adress: "adress", zipCodesList: [], logo: "");
  }

  Future<void> getSelectedStore({required DocumentReference storeRef}) async {
    final DocumentSnapshot<Object?> storeSnapshot = await storeRef.get();

    final store = Stores(
        id: storeSnapshot.id,
        name: storeSnapshot['name'],
        adress: "",
        zipCodesList: [],
        logo: storeSnapshot['logo']);

    state = AsyncValue.data(store);
  }
}
