import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/firestore_pref_mixin.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'my_list_repository.g.dart';

@riverpod
class MyListRepository extends _$MyListRepository with FirestoreAndPrefsMixin {
  @override
  ApiResponse build() {
    return ApiResponse();
  }

  Future<void> saveMyList(MyListModel myListModel, File? image) async {
    try {
      state = ApiResponse.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase();
      }

      final myListCollection =
          fireStore.collection(MyListConstant.myListCollection);
      final myListRequest = myListModel.copyWith(
          uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);

      await myListCollection.add(myListRequest.toJson());
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
    }
  }

  Future<void> addProductToNewList(MyListModel myListModel, File? image,
      String productId, String productRef) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase();
      }
      DocumentReference<Map<String, dynamic>> myListDocument =
          fireStore.collection(MyListConstant.myListCollection).doc();

      final myListRequest = myListModel.copyWith(
          uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);
      await myListDocument.set(myListRequest.toJson());

      CollectionReference<Map<String, dynamic>> userProductList =
          myListDocument.collection(MyListConstant.userProductList);

      DocumentReference<Map<String, dynamic>> productReference =
          await fireStore.collection('products').doc(productRef);

      userProductList.add({
        'product_ref': productReference,
        'product_id': productId,
        'quantity': 1
      });
      // userProductList.add(userProductRequest.toJson());
      print("productId : $productId");
    } catch (error) {
      print("Error adding product to user's list: $error");
    }
  }

  Future<List<MyListModel>> fetchMyList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      state = ApiResponse.loading();
      final snapShot = await fireStore
          .collection(MyListConstant.myListCollection)
          .where('uid', isEqualTo: userId)
          .get();

      final List<MyListModel> mylists = snapShot.docs.map((doc) {
        final data = doc.data();
        final list = MyListModel.fromJson(data).copyWith(documentId: doc.id);
        return list;
      }).toList();

      mylists.forEach((element) {
        print("mylists: ${element.name}");
      });

      state = ApiResponse.success(data: mylists);
      if (mylists.isEmpty) {
        return [];
      }

      return mylists;
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      return [];
    }
  }
}
