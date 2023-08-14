import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../../utils/fireStore_constants.dart';
import '../data/my_list_model.dart';

part 'add_product_to_new_list_provider.g.dart';


@riverpod
class AddProdToNewList extends _$AddProdToNewList with FirestoreAndPrefsMixin {

  @override
  FutureOr<void> build(){
  }

  Future<void> addProductToNewList(MyListModel myListModel,File? image,String productId, String productRef, BuildContext context) async {
    try{
     state = AsyncValue.loading();
      final userId = await prefs.then((prefs) => prefs.getUserId());
     DocumentReference<Map<String, dynamic>> userReference = fireStore.collection(UserConstant.userCollection).doc(userId);


     String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase( path: "myList");
      }
      DocumentReference<Map<String, dynamic>> myListDocument = fireStore
          .collection(MyListConstant.myListCollection)
          .doc();

      final myListRequest = myListModel.copyWith(uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);
      //await myListDocument.set(myListRequest.toJson());
     await myListDocument.set(
         {
           'uid': userId,
           'usersRef': userReference,
           'myListPhoto': downloadURL,
         'description':myListModel.description,
         'name':myListModel.name}

     );

      CollectionReference<Map<String, dynamic>> userProductList =
      myListDocument.collection(MyListConstant.userProductList);

      DocumentReference<Map<String, dynamic>> productReference = fireStore
          .collection('products')
          .doc(productRef);


      userProductList.add({
        'product_ref':productReference,
        'product_id':productId,
        'quantity' : 1
      });
      // userProductList.add(userProductRequest.toJson());
      print("productId : $productId");
      state = AsyncValue.data(null);
      context.pop(true);

    }catch(error,stackTrace){
      state = AsyncValue.error(error, stackTrace);
    }
  }
}