import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/repo/home_actions.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../../utils/fireStore_constants.dart';
import '../data/my_list_model.dart';

part 'fetch_mylist_provider.g.dart';

@riverpod
class FetchMyList extends _$FetchMyList
    with FirestoreAndPrefsMixin
    implements PopUpActions {
  @override
  FutureOr<List<MyListModel>> build() {
    return fetchMyListFun();
  }

  Future<List<MyListModel>> fetchMyListFun() async {
    try {
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());

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
        final listRef = doc['list_ref'] as DocumentReference;
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
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }

  @override
  Future<bool> copyTheList({required String path}) async {
    try {
      final userId = await prefs.then((prefs) => prefs.getUserId());
      final userList = fireStore.doc(path);

      final userListSnapshot = await userList.get();

      final batch = fireStore.batch();
      // Create a new map with modified name
      final modifiedData = Map<String, dynamic>.from(userListSnapshot.data()!);
      // Format current datetime and append it to the original name
      final currentDate = DateTime.now();
      final formattedDate =
          DateFormat('yyyy-MM-dd_HH:mm:ss').format(currentDate);
      final newName = 'Copied ${modifiedData['name']} ($formattedDate)';

      modifiedData['name'] = newName; // Change to the desired modified name
      modifiedData['uid'] = userId; // Change to the desired modified name
      modifiedData['userRef'] =
          fireStore.collection(UserConstant.userCollection).doc(userId);

      // Create a new document to store the copied list
      final newListRef = await fireStore
          .collection(MyListConstant.myListCollection)
          .add(modifiedData);

      // Iterate through the user_product_list subcollection and add each document to the new list
      final userProductListSnapshot =
          await userList.collection(MyListConstant.userProductList).get();
      userProductListSnapshot.docs.forEach((doc) {
        final data = doc.data();
        batch.set(
            newListRef.collection(MyListConstant.userProductList).doc(), data);
      });

      // Commit the batch operation to Firestore
      await batch.commit();

      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'no-internet') {
        debugPrint('No internet connection. Please check your network.');
      } else {
        debugPrint('Firestore exception: ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('Error searching products: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteTheList({required String path}) async {
    try {
      final userList = fireStore.doc(path);

      final batch = fireStore.batch();

      final userProductListSnapshot =
          await userList.collection(MyListConstant.userProductList).get();
      userProductListSnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      batch
        ..delete(userList)
        ..commit();

      debugPrint("listPath $path");

      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'no-internet') {
        debugPrint('No internet connection. Please check your network.');
      } else {
        debugPrint('Firestore exception: ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('Error searching products: $e');
      return false;
    }
  }

  Future<void> redirectUserToListDetailsScreen(
      {required BuildContext context,
      required String listId,
      required String name,
      required String photo,
      required String path}) async {
    await prefs.then((prefs) {
      prefs.setString("user_list_name", MyListConstant.myListCollection);
      prefs.setString("user_list_id", listId);
    });

    final bool? result = await context
        .pushNamed(RouteManager.myListDetailScreen, queryParameters: {
      'list_id': listId,
      'name': name,
      'photo': photo,
      'path': path
    });
    print("resultValue $result");
    if (result ?? false) {
      fetchMyListFun();
    }
  }
}
