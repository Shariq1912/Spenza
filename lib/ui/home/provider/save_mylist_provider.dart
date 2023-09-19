import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/provider/fetch_mylist_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../utils/fireStore_constants.dart';
import '../data/my_list_model.dart';
import 'image_picker_provider.dart';

part 'save_mylist_provider.g.dart';

@riverpod
class SaveMyList extends _$SaveMyList with FirestoreAndPrefsMixin {
  @override
  FutureOr<void> build(){
  }

  Future<void> saveMyListFun(MyListModel myListModel, File? image,BuildContext context) async {
    try {
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());

      DocumentReference<Map<String, dynamic>> userReference = fireStore.collection(UserConstant.userCollection).doc(userId);

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase( path: "myList");
      }

      final myListCollection = fireStore.collection(MyListConstant.myListCollection);
      final myListRequest = myListModel.copyWith(uid: userId, usersRef: "/users/$userId", myListPhoto: downloadURL);

      await myListCollection.add(myListRequest.toJson());
      /*await myListCollection.add(
          { 'uid': userId,
            'usersRef': userReference,
            'myListPhoto': downloadURL}

      );*/


      ref.read(fetchMyListProvider.notifier).fetchMyListFun();
      context.pop(true);
      ref.read(imagePickerProvider.notifier).state = null;
      //context.pop();


    } catch (error,stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}