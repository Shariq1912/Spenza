import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'fetch_mylist_provider.dart';

part 'home_preloaded_list.g.dart';

@riverpod
class HomePreloadedList extends _$HomePreloadedList
    with FirestoreAndPrefsMixin {
  @override
  FutureOr<List<PreloadedListModel>> build() {
    return [];
  }

  Future<List<PreloadedListModel>> fetchPreloadedList() async {
    try {
      state = AsyncValue.loading();
      final userId = await prefs.then((prefs) => prefs.getUserId());
      final snapShot = await fireStore
          .collection(PreloadedListConstant.collectionName)
          .get();

      final List<PreloadedListModel> preloadedList =
          await Future.wait(snapShot.docs.map((doc) async {
        final data = doc.data();
        data['id'] = doc.id;
        data['path'] = doc.reference.path;

        final snapShots = await fireStore
            .collection(ReceiptConstant.collectionName)
            .where(ReceiptConstant.userIdField, isEqualTo: userId)
            .where(ReceiptConstant.receiptRef,
                isEqualTo: fireStore.doc(doc.reference.path))
            .count()
            .get();

        final count = snapShots.count;
        data['count'] = count.toString();
        print("counts $count , ${doc.reference.path.toString()}");
        final list = PreloadedListModel.fromJson(data);
        return list;
      }).toList());

      preloadedList.forEach((element) {
        print("preloadedList: ${element.name}");
      });

      state = AsyncValue.data(preloadedList);
      return preloadedList;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }

  Future<void> redirectUserToListDetailsScreen(
      {required BuildContext context,
      required String listId,
      required String name,
      required String photo,
      required WidgetRef ref}) async {
    await prefs.then((prefs) {
      prefs.setString("user_list_name", PreloadedListConstant.collectionName);
      prefs.setString("user_list_id", listId);
    });

    final bool? result = await context.pushNamed(
        RouteManager.preLoadedListDetailScreen,
        queryParameters: {'list_id': listId, 'name': name, 'photo': photo});
    if (result ?? false) {
      ref.read(fetchMyListProvider.notifier).fetchMyListFun();
    }
  }

  Future<bool> copyDocument(String itemPath) async {
    try {
      final userId = await prefs.then((prefs) => prefs.getUserId());
      final sourceDocument = fireStore.doc(itemPath);
      final sourceDocSnapshot = await sourceDocument.get();
      final sourceData = sourceDocSnapshot.data();

      final targetCollection =
          fireStore.collection(MyListConstant.myListCollection);
      final newDocumentRef = targetCollection.doc();

      final copiedData = Map<String, dynamic>.from(sourceData!);
      if (copiedData.containsKey('preloaded_photo')) {
        copiedData['myListPhoto'] = copiedData['preloaded_photo'];
        copiedData.remove('preloaded_photo');
      }
      copiedData['uid'] = userId;
      copiedData['usersRef'] =
          fireStore.collection(UserConstant.userCollection).doc(userId);

      final batch = fireStore.batch();

      await newDocumentRef.set(copiedData);

      final sourceSubCollection =
          sourceDocument.collection(PreloadedListConstant.subCollectionName);
      final targetSubCollection =
          newDocumentRef.collection(MyListConstant.userProductList);

      final subCollectionSnapshot = await sourceSubCollection.get();
      final subCollectionDocs = subCollectionSnapshot.docs;

      for (final subDoc in subCollectionDocs) {
        final subData = subDoc.data();
        final targetDocRef = targetSubCollection.doc(subDoc.id);
        batch.set(targetDocRef, subData);
      }

      return await batch.commit().then((value) => true);

    } catch (e) {
      debugPrint('Error copying document: $e');
      return false;
    }
  }
}
