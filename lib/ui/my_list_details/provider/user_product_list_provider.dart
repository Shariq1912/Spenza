import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/firestore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'user_product_list_provider.g.dart';

@riverpod
class UserProductList extends _$UserProductList with FirestoreAndPrefsMixin {
  @override
  Future<List<UserProduct>> build() async {
    return [];
  }

  Future<void> fetchProductFromListId() async {
    state = AsyncValue.loading();

    final listId = await prefs.then((prefs) => prefs.getUserListId());

    try {
      final productListRef = await fireStore
          .collection(MyList.collectionName)
          .doc(listId)
          .collection(UserProductListCollection.collectionName)
          .get();

      // Create a list of Product Ref objects
      final productRefs = productListRef.docs
          .map((snapshot) => snapshot[ProductCollectionConstant.productRef]
              as DocumentReference)
          .toList();

      final productDocs =
          await Future.wait(productRefs.map((productRef) => productRef.get()));

      final List<UserProduct> productList = [];

      for (var i = 0; i < productDocs.length; i++) {
        final DocumentSnapshot<Object?> data = productDocs[i];
        final snapshot = productListRef.docs[i];

        final genericNames = (data['genericNames'] as List<dynamic>)
            .map((name) => name.toString().toLowerCase())
            .toSet()
            .toList();

        final priceRange = _findPriceRangeFromGenericNames(genericNames);

        productList.add(UserProduct(
          productId: productRefs[i].path,
          department: data['department_name'],
          name: data['name'],
          minPrice: 'minPrice',
          maxPrice: 'maxPrice',
          quantity: snapshot['quantity'],
          pImage: data['pImage'],
          measure: data['measure'] == "kg" ? "1 kg" : data['measure'],
        ));
      }

      print(productList.toString());
      state = AsyncValue.data(productList);
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
    QuerySnapshot snapshot = await fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .where(
          ProductCollectionConstant.productRef,
          isEqualTo: fireStore.doc(
            product.productId,
          ), // type cast to Document reference from path
        )
        .get();

    final doc = snapshot.docs.first;
    fireStore.batch()
      ..delete(doc.reference)
      ..commit();

    final data = state.requireValue;
    data.remove(
        data.firstWhere((element) => element.productId == product.productId));

    state = AsyncValue.data(data);
  }

  Future<void> saveUserProductListToServer(
      {required BuildContext context}) async {
    final List<UserProduct> data = state.requireValue;

    final listId = await prefs.then((prefs) => prefs.getUserListId());

    final userProductsCollection = await fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .get();

    final batch = fireStore.batch();
    userProductsCollection.docs.forEach((doc) {
      final UserProduct matchingElement = data.firstWhere(
        (element) =>
            element.productId == doc['product_ref'].path, // matching both path
      );
      batch.update(doc.reference, {'quantity': matchingElement.quantity});
    });

    await batch.commit();

    print("Data Updated Successfully");

    context.pushNamed(RouteManager.storeRankingScreen);
  }
}
