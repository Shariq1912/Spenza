import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../../utils/fireStore_constants.dart';
import '../data/my_list_model.dart';

part 'fetch_mylist_provider.g.dart';

@riverpod
class FetchMyList extends _$FetchMyList with FirestoreAndPrefsMixin {

  @override
  FutureOr<List<MyListModel>> build(){
    return fetchMyListFun();
  }

  Future<List<MyListModel>> fetchMyListFun() async {
    try {
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());
      /*final snapShot = await fireStore
          .collection(MyListConstant.myListCollection)
          .where('uid', isEqualTo: userId)
          .get();

      final List<MyListModel> mylists = await Future.wait(snapShot.docs.map((doc) async {
        final data = doc.reference;
        final snapShots = await fireStore
            .collection(ReceiptConstant.collectionName).where("uid", isEqualTo: userId)
            .where('list_ref', isEqualTo: fireStore.doc(doc.reference.path))
            .count().get();
        final count = snapShots.count;

        return MyListModel(
            description:doc['description'].toString(),
            name: doc['name'].toString(),
            uid: doc['uid'], usersRef: doc['usersRef'].toString(),
        myListPhoto: doc['myListPhoto'],
        path: doc.reference.path,
        count: count.toString(),
        documentId: doc.id.toString());

      }).toList());*/

      final QuerySnapshot myListSnapshot = await fireStore
          .collection(MyListConstant.myListCollection)
          .where('uid', isEqualTo: userId)
          .get();

      final Map<String, MyListModel> myListMap = {};

      myListSnapshot.docs.forEach((doc) {
        final myList = MyListModel(
          description: doc['description'].toString(),
          name: doc['name'].toString(),
          uid: doc['uid'],
          usersRef: doc['usersRef'].toString(),
          myListPhoto: doc['myListPhoto'],
          path: doc.reference.path,
          count: '0',
          documentId: doc.id.toString(),
        );

          print("mylist: ${myList.name}");

        myListMap[myList.path!] = myList;
      });

      final QuerySnapshot receiptSnapshot = await fireStore
          .collection(ReceiptConstant.collectionName)
          .where("uid", isEqualTo: userId)
          .get();

      receiptSnapshot.docs.forEach((doc) {
        final listRef = doc['list_ref'] as DocumentReference ;
        final listPath = listRef.path;

        if (myListMap.containsKey(listPath)) {
          myListMap[listPath] = myListMap[listPath]!.copyWith(
            count: (int.parse(myListMap[listPath]!.count!) + 1).toString(),
          );
        }
      });

      final List<MyListModel> mylists = myListMap.values.toList();



      mylists.forEach((element) {
        print("mylists: ${element.name}");
      });


      state = AsyncValue.data(mylists);
      return mylists;
    } catch (error,stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }
  Future<void> redirectUserToListDetailsScreen({required BuildContext context, required String listId}) async {
     await prefs.then((prefs){
       prefs.setString("user_list_name", MyListConstant.myListCollection);
       prefs.setString("user_list_id", listId);
     });

     final bool? result = await context.pushNamed(RouteManager.myListDetailScreen,
         queryParameters: {'list_id': listId});

     if(result ?? false){
       fetchMyListFun();
     }

  }

}