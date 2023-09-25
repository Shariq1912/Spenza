import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/data/user_product_insert.dart';
import 'package:spenza/ui/selected_store/data/selected_product.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_to_my_list_provider.g.dart';

@riverpod
class AddProductToMyList extends _$AddProductToMyList
    with FirestoreAndPrefsMixin {
  final Set<DocumentReference> selectedProductsRef = {};

  @override
  FutureOr<void> build() {}

  Future<bool> addProductToMyList(
      {required String listId,
      required String productId,
      required String productRef,
      required BuildContext context,
      bool hasToPop = true}) async {
    try {
      DocumentReference productReference =
          fireStore.collection('products_mvp').doc(productRef);

      CollectionReference userProductList =
          fireStore.collection(MyList.collectionName).doc(listId).collection(
                MyListConstant.userProductList,
              );

      final query = await userProductList
          .where(
            ProductCollectionConstant.productId,
            isEqualTo: productId,
          )
          .limit(1)
          .get();

      var isProductExist = query.docs.isNotEmpty;

      if (isProductExist) {
        context.showSnackBar(message: "Product Already Exist in the List");
        return false;
      }

      final userProduct = UserProductInsert(
        productRef: productReference,
        productId: productId,
      );

      userProductList.add(userProduct.toJson());
      context.showSnackBar(message: "Product successfully added in the List");

      print("productId : $productId");

      if (hasToPop) {
        context.pop();
      } else {
        selectedProductsRef.add(productReference);
        await saveSelectedStoreProducts();
      }
      return true;
      // context.pop(true);
    } catch (error) {
      print("Error adding product to user's list: $error");
      return false;
    }
  }

  /// Function to update cached data of store of userID
  Future<void> saveSelectedStoreProducts() async {
    if (selectedProductsRef.isEmpty) {
      return;
    }

    final userId = await prefs.then((prefs) => prefs.getUserId());
    // final userId = "Cool User";

    final DocumentSnapshot<Map<String, dynamic>> query =
        await fireStore.collection('ranked_store_products').doc(userId).get();

    final total = query['total'] ?? 0.0;
    final List<dynamic> matchingProductsData = query['matching_products'];

    final List<SelectedProductElement> matchingProducts = matchingProductsData
        .map((productData) => SelectedProductElement.fromJson(productData))
        .toList();

    final List<Product> userSelectedProducts =
        await _getProductsFromProductRef();

    print("USER SELECTED PRODUCTS ++++ ==== $userSelectedProducts");

    // Calculate the sum of minPrice for userSelectedProducts
    final double userSelectedTotal = userSelectedProducts.fold(total,
        (prev, product) => prev + (double.tryParse(product.minPrice) ?? 0.0));

    // Round the updatedTotal to two decimal places
    final updatedTotal = double.parse(userSelectedTotal.toStringAsFixed(2));

    matchingProducts.addAll(
      userSelectedProducts.map(
        (product) =>
            SelectedProductElement.fromProduct(product).copyWith(quantity: 1),
      ),
    );

    final modifiedSelectedProducts = {
      "matching_products": matchingProducts.map((e) => e.toJson()).toList(),
      "total": updatedTotal,
    };

    // Now, batch update the data in Firestore
    final batch = fireStore.batch();
    final docRef = fireStore.collection('ranked_store_products').doc(userId);
    batch.update(docRef, modifiedSelectedProducts);

    // Commit the batch update
    await batch.commit();
  }

  Future<List<Product>> _getProductsFromProductRef() async {
    return await Future.wait(
      selectedProductsRef.map(
        (ref) async {
          final productSnapshot = await ref.get();
          return Product.fromDocument(productSnapshot);
        },
      ).toList(),
    );
  }
}
