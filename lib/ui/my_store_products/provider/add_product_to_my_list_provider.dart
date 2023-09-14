import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/add_product/data/user_product_insert.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_to_my_list_provider.g.dart';

@riverpod
class AddProductToMyList extends _$AddProductToMyList
    with FirestoreAndPrefsMixin {
  @override
  FutureOr<void> build() {}

  Future<bool> addProductToMyList({
    required String listId,
    required String productId,
    required String productRef,
    required BuildContext context,
  }) async {
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
      context.pop();
      return true;
      // context.pop(true);
    } catch (error) {
      print("Error adding product to user's list: $error");
      return false;
    }
  }
}
