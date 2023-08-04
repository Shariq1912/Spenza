import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/my_list_details/data/similar_product_matcher.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'user_product_list_provider.g.dart';

@riverpod
class UserProductList extends _$UserProductList {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late SharedPreferences _prefs;

  @override
  Future<List<UserProduct>> build() async {
    _prefs = await SharedPreferences.getInstance();
    return [];
  }

  Future<void> fetchProductFromListId(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    state = AsyncValue.loading();

    try {
      final productListRef = _fireStore
          .collection(MyList.collectionName)
          .doc(listId)
          .collection(UserProductListCollection.collectionName);

      final List<UserProduct> productList = [];
      productListRef.snapshots().listen((event) async {
        productList.clear();
        for (var snapshot in event.docs) {
          final DocumentReference productRef =
              snapshot[ProductCollectionConstant.productRef];
          final DocumentSnapshot<Object?> data = await productRef.get();

          final genericNames = (data['genericNames'] as List<dynamic>)
              .map((name) => name.toString().toLowerCase())
              .toSet()
              .toList();

          _findPriceRangeFromGenericNames(genericNames);

          productList.add(UserProduct(
            productId: data['product_id'],
            department: data['department_name'],
            name: data['name'],
            minPrice: "minPrice".toString(),
            maxPrice: "maxPrice".toString(),
            quantity: snapshot['quantity'],
            pImage: data['pImage'],
            measure: data['measure'] == "kg" ? "1 kg" : data['measure'],
          ));
        }

        print(productList.toString());
        state = AsyncValue.data(productList);
      });
    } catch (e) {
      print('Error fetching Product List: $e');
    }
  }

  _findPriceRangeFromGenericNames(List<String> genericNames) {
    // todo implement logic
  }

  Future<void> updateUserProductList(
      {required UserProduct product, required int quantity}) async {
    final List<UserProduct> data = state.requireValue;
    final index = data.indexOf(product);
    if (index != -1) {
      data[index] = product.copyWith(quantity: quantity);
    }

    state = AsyncValue.data(data);
  }

  Future<void> deleteProductFromUserList({
    required UserProduct product,
    required String listId,
  }) async {
    // Fetch the user's product list from the user_product_list subcollection
    QuerySnapshot snapshot = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .where(
          ProductCollectionConstant.productId,
          isEqualTo: product.productId,
        )
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();

      /*final data = state.requireValue;
      data.remove(
          data.firstWhere((element) => element.idStore == product.idStore));
      state = AsyncValue.data(data);*/
    }
  }

  Future<void> saveUserProductListToServer(
      {String listId = "4NlYnhmchdlu528Gw2yK",
      required BuildContext context}) async {
    final List<UserProduct> data = state.requireValue;


    final userProductsCollection = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .get();

    final batch = _fireStore.batch();
    userProductsCollection.docs.forEach((doc) {
      final UserProduct matchingElement = data.firstWhere(
        (element) => doc['product_id'] == element.productId,
      );
      batch.update(doc.reference, {'quantity': matchingElement.quantity});
    });

    await batch.commit();

    print("Data Updated Successfully");

    context.pushNamed(RouteManager.storeRankingScreen);
  }

}
