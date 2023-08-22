import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';

part 'home_preloaded_list.g.dart';

@riverpod
class HomePreloadedList extends _$HomePreloadedList with FirestoreAndPrefsMixin {

  @override
  FutureOr<List<PreloadedListModel>> build(){
    return fetchPreloadedList();
  }
  /*
  Future<List<PreloadedListModel>> fetchPreloadedList() async {
    try{
      state = AsyncValue.loading();
      
      final snapShot = await fireStore.collection(PreloadedListConstant.collectionName).get();


      final List<PreloadedListModel> preloadedList = snapShot.docs.map((doc){
        final data = doc.data();
        data['id'] = doc.id;
        data['path'] = doc.reference.path;
        final snapShots =  fireStore
            .collection("receipt")
            .where('list_ref', isEqualTo: doc.reference.path)
            .count().get().then((value) => value.count);

        print("counts $snapShots");
        final list = PreloadedListModel.fromJson(data);
        return list;
      }).toList();

      preloadedList.forEach((element) {
        print("preloadedList: ${element.name}");
      });

      state = AsyncValue.data(preloadedList);
      return preloadedList;
    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }*/
  Future<List<PreloadedListModel>> fetchPreloadedList() async {
    try {
      state = AsyncValue.loading();

      final snapShot = await fireStore.collection(PreloadedListConstant.collectionName).get();

      final List<PreloadedListModel> preloadedList = await Future.wait(snapShot.docs.map((doc) async {
        final data = doc.data();
        data['id'] = doc.id;
        data['path'] = doc.reference.path;

        final snapShots = await fireStore
            .collection("receipt")
            .where('list_ref', isEqualTo: doc.reference.path)
            .get();

        final count = snapShots.size;

        print("counts $count");
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


  Future<void> redirectUserToListDetailsScreen({required BuildContext context, required String listId}) async {
    await prefs.then((prefs){
      prefs.setString("user_list_name", PreloadedListConstant.collectionName);
      prefs.setString("user_list_id", listId);
    });

    final bool? result = await context.pushNamed(RouteManager.preLoadedListDetailScreen,
        queryParameters: {'list_id': listId});



  }
}