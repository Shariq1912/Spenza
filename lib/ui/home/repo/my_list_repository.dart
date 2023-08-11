import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'my_list_repository.g.dart';

@riverpod
class MyListRepository extends _$MyListRepository {
  @override
  FutureOr<List<MyListModel>> build() {
  return [];
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveMyList(MyListModel myListModel, File? image) async {
    try {
      state = AsyncValue.loading();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase("myList");
      }

      final myListCollection = _firestore.collection(MyListConstant.myListCollection);
      final myListRequest = myListModel.copyWith(uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);

      //await myListCollection.add(myListRequest.toJson());
      final DocumentReference docRef = await myListCollection.add(myListRequest.toJson());
      final savedMyList = myListModel.copyWith(documentId: docRef.id);

      final currentList = state.asData?.value ?? [];
      currentList.add(savedMyList);

      state = AsyncValue.data(currentList);

    } catch (error,stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addProductToNewList(MyListModel myListModel,File? image,String productId, String productRef) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase("myList");
      }
      DocumentReference<Map<String, dynamic>> myListDocument = _firestore
          .collection(MyListConstant.myListCollection)
          .doc();

      final myListRequest = myListModel.copyWith(uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);
      await myListDocument.set(myListRequest.toJson());

      CollectionReference<Map<String, dynamic>> userProductList =
      myListDocument.collection(MyListConstant.userProductList);

      DocumentReference<Map<String, dynamic>> productReference = await _firestore
          .collection('products')
          .doc(productRef);


      userProductList.add({
        'product_ref':productReference,
        'product_id':productId,
        'quantity' : 1
      });
      // userProductList.add(userProductRequest.toJson());
      print("productId : $productId");

    }catch(error){print("Error adding product to user's list: $error");
    }
  }

  Future<void> fetchMyList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      state = AsyncValue.loading();
      final snapShot = await _firestore
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


      if(mylists.isEmpty){
        //return [];
      }
      state = AsyncValue.data(mylists);
      //return mylists;
    } catch (error,stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      //return [];
    }
  }




}
