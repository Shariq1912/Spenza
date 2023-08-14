import 'dart:math';
import 'package:intl/intl.dart';
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
    final listName = await prefs.then((prefs) => prefs.getUserListName());

    try {
      final productListRef = await fireStore
          // .collection(MyList.collectionName)    /// get name from SharedPref
          .collection(listName)
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

  Future<void> copyTheList({required BuildContext context}) async {
    final listId = await prefs.then((prefs) => prefs.getUserListId());
    final collectionName = await prefs.then((prefs) => prefs.getUserListName());
    final userList = fireStore.collection(collectionName).doc(listId);

    final userListSnapshot = await userList.get();
    final userProductListSnapshot =
        await userList.collection(MyListConstant.userProductList).get();

    final batch = fireStore.batch();
    // Create a new map with modified name
    final modifiedData = Map<String, dynamic>.from(userListSnapshot.data()!);
    // Format current datetime and append it to the original name
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd_HH:mm:ss').format(currentDate);
    final newName = 'Copied ${modifiedData['name']} ($formattedDate)';

    modifiedData['name'] = newName; // Change to the desired modified name

    // Create a new document to store the copied list
    final newListRef =
        await fireStore.collection(collectionName).add(modifiedData);

    // Iterate through the user_product_list subcollection and add each document to the new list
    userProductListSnapshot.docs.forEach((doc) {
      final data = doc.data();
      batch.set(
          newListRef.collection(MyListConstant.userProductList).doc(), data);
    });

    // Commit the batch operation to Firestore
    await batch.commit();

    context.showSnackBar(message: "$listId Copied Successfully!");
  }

  Future<void> deleteTheList({required BuildContext context}) async {
    final listId = await prefs.then((prefs) => prefs.getUserListId());
    final collectionName = await prefs.then((prefs) => prefs.getUserListName());
    final userList =
        fireStore.collection(collectionName).doc("guCMnbhN0R081n5RxFyl");
    final userProductListSnapshot =
        await userList.collection(MyListConstant.userProductList).get();

    final batch = fireStore.batch();
    // Delete documents in the subcollection
    userProductListSnapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    batch
      ..delete(userList)
      ..commit();

    context.showSnackBar(message: "$listId Deleted Successfully!");
  }

  Future<void> redirectFromPreloadedList(
      {required BuildContext context}) async {
    context.pushNamed(RouteManager.storeRankingScreen);
  }
}
