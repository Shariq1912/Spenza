import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/firestore_pref_mixin.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'edit_list_provider.g.dart';

@riverpod
class EditList extends _$EditList with FirestoreAndPrefsMixin {
  @override
  Future<String> build() async {
    return "";
  }

  Future<void> saveTheListDetails(
      MyListModel myListModel, File? image, BuildContext context) async {
    try {
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());
      final listId = await prefs.then((prefs) => prefs.getUserListId());
      final listName = await prefs.then((prefs) => prefs.getUserListName());

      final listRef = fireStore.collection(listName).doc(listId);

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase(path: listName);
      }

      final myListRequest = myListModel
          .copyWith(
            uid: userId,
            usersRef: "/users/$userId",
            myListPhoto:
                downloadURL == null ? myListModel.myListPhoto : downloadURL,
          )
          .toJson();

      myListRequest['usersRef'] =
          fireStore.collection(UserConstant.userCollection).doc(userId);

      fireStore.batch()..set(listRef, myListRequest)..commit();

      state = AsyncData("Edited Successfully!");
      context.pop(true);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
