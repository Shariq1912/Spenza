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
  ApiResponse build() {
    return ApiResponse();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveMyList(MyListModel myListModel, File? image) async {
    try {
      state = ApiResponse.loading();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase();
      }

      final myListCollection = _firestore.collection(MyListConstant.myListCollection);
      final myListRequest = myListModel.copyWith(uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);

      await myListCollection.add(myListRequest.toJson());
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
    }
  }

  Future<List<MyListModel>> fetchMyList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      state = ApiResponse.loading();
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

      state = ApiResponse.success(data: mylists);
      if(mylists.isEmpty){
        return [];
      }

      return mylists;
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      return [];
    }
  }




}
