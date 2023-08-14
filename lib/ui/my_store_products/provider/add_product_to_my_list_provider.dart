import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';

import '../../../utils/fireStore_constants.dart';

part 'add_product_to_my_list_provider.g.dart';

@riverpod
class AddProductToMyList extends _$AddProductToMyList with FirestoreAndPrefsMixin{
  @override
  FutureOr<void> build(){
  }

  Future<void> addProductToMyList(String? documentId, String productId, String productRef, BuildContext context) async {
    try{
      state = AsyncValue.loading();
      DocumentReference<Map<String, dynamic>> productReference = await fireStore
          .collection('products')
          .doc(productRef);

      CollectionReference<Map<String, dynamic>> userProductList = await fireStore
          .collection(MyListConstant.myListCollection)
          .doc(documentId)
          .collection(MyListConstant.userProductList);

//    final userProductRequest = userProductData.copyWith(productId: 'products/$productId');
      userProductList.add({
        'product_ref':productReference,
        'product_id':productId,
        'quantity' : 1
      });
      // userProductList.add(userProductRequest.toJson());
      print("productId : $productId");
      state = AsyncValue.data(null);
      context.pop(true);

    }catch(error){print("Error adding product to user's list: $error");
    }
  }
}