import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../utils/fireStore_constants.dart';
import '../data/my_list_model.dart';

part 'fetch_mylist_provider.g.dart';

@riverpod
class FetchMyList extends _$FetchMyList with FirestoreAndPrefsMixin {

  @override
  FutureOr<List<MyListModel>> build(){
    return [];
  }

  Future<List<MyListModel>> fetchMyListFun() async {
    try {
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());
      final snapShot = await fireStore
          .collection(MyListConstant.myListCollection)
          .where('uid', isEqualTo: userId)
          .get();

      final List<MyListModel> mylists = snapShot.docs.map((doc) {
        final data = doc.reference;
        /*final list = MyListModel.fromJson(data).copyWith(documentId: doc.id);
        return list;*/
        return MyListModel(
            description:doc['description'].toString(),
            name: doc['name'].toString(),
            uid: doc['uid'], usersRef: doc['usersRef'].toString(),
        myListPhoto: doc['myListPhoto'],
        documentId: doc.id.toString());
      }).toList();


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
}