import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
part 'zipcode_provider.g.dart';

@riverpod
class Zipcode extends _$Zipcode with FirestoreAndPrefsMixin{

  @override
  FutureOr<List<int>> build(){
    return [];
  }

  Future<List<int>> fetchZipCode() async {
    try{
      state = AsyncValue.loading();
      final zips = await fireStore.collection("zipcodes").get();
      final codes = zips.docs.map((doc) {
        final data = doc.data();
        return data['zipcode'] as int;
      }).toList();

      codes.forEach((element) {
        print(" zipps ${element}");
      });


      state = AsyncValue.data(codes);
      return codes;


    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }
}