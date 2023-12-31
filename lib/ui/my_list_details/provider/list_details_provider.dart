import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/selected_store/data/selected_product.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'package:collection/collection.dart';

part 'list_details_provider.g.dart';

@riverpod
class ListDetails extends _$ListDetails with FirestoreAndPrefsMixin {
  @override
  Future<MyListModel> build() async {
    return MyListModel(description: "", name: "", uid: "", usersRef: "");
  }

  Future<void> getSelectedListDetails({bool isPreloadedList = false}) async {
    final listId = await prefs.then((prefs) => prefs.getUserListId());
    final listName = await prefs.then((prefs) => prefs.getUserListName());

    final listRef = fireStore.collection(listName).doc(listId);
    final DocumentSnapshot<Object?> storeSnapshot = await listRef.get();

    final list = MyListModel(
      description: storeSnapshot['description'],
      name: storeSnapshot['name'],
      uid: "",
      usersRef: "",
      myListPhoto: isPreloadedList
          ? storeSnapshot['preloaded_photo']
          : storeSnapshot['myListPhoto'],
    );

    state = AsyncValue.data(list);
  }
}
