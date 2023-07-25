import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/utils/firestore_constants.dart';

part 'user_product_list_provider.g.dart';

@riverpod
class UserProductList extends _$UserProductList {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<List<UserProduct>> build() async {
    return [];
  }

  Future<void> fetchProductFromListId(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    state = AsyncValue.loading();

    try {
      final productListRef = await _fireStore
          .collection(MyList.collectionName)
          .doc(listId)
          .collection(UserProductListCollection.collectionName)
          .get();

      final productList = productListRef.docs
          .map(
            (data) => UserProduct(
              idStore: data['idStore'],
              department: data['department'],
              name: data['name'],
              minPrice: data['minPrice'].toString(),
              maxPrice: data['maxPrice'].toString(),
              quantity: data['quantity'],
              pImage: data['pImage'],
              measure: data['measure'],
            ),
          )
          .toList();

      print(productList.toString());
      state = AsyncValue.data(productList);
    } catch (e) {
      print('Error fetching Product List: $e');
    }
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

  Future<void> saveUserProductListToServer(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    final List<UserProduct> data = state.requireValue;
    final userProductsCollection = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    userProductsCollection.docs.forEach((doc) {
      final UserProduct matchingElement =
          data.firstWhere((element) => element.idStore == doc['idStore']);
      batch.update(doc.reference, {'quantity': matchingElement.quantity});
    });

    await batch.commit();

    print("Data Updated Successfully");
  }
}
