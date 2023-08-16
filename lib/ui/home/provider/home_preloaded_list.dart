import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';
import 'package:spenza/utils/firestore_constants.dart';

part 'home_preloaded_list.g.dart';

@riverpod
class HomePreloadedList extends _$HomePreloadedList with FirestoreAndPrefsMixin {

  @override
  FutureOr<List<PreloadedListModel>> build(){
    return [];
  }
  
  Future<List<PreloadedListModel>> fetchPreloadedList() async {
    try{
      state = AsyncValue.loading();
      
      final snapShot = await fireStore.collection(PreloadedListConstant.preloadedListCollection).get();

      final List<PreloadedListModel> preloadedList = snapShot.docs.map((doc){
        final data = doc.data();
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
  } 
}