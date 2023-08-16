import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../data/district_data.dart';

part 'fetch_district_from_zipcode.g.dart';

@riverpod
class FetchDistrictFromZipCode extends _$FetchDistrictFromZipCode with FirestoreAndPrefsMixin {
  @override
  FutureOr<String> build(){
    return "";
  }

  Future<String> fetchDistrictNameFromZipcode(int zipcodeValue) async {
    try{
      state = AsyncValue.loading();
      final userId = await prefs.then((prefs) => prefs.getUserId());

      QuerySnapshot querySnapshot = await fireStore
          .collection('zipcodes')
          .where('zipcode', isEqualTo: zipcodeValue)
          .get();

      DocumentSnapshot zipcodeDocument = querySnapshot.docs.first;
      DocumentReference districtRef = zipcodeDocument.get('districtRef');
      DocumentSnapshot districtSnapshot = await districtRef.get();

      if (districtSnapshot.exists) {
        Map<String, dynamic>? districtDataJson =
        districtSnapshot.data() as Map<String, dynamic>?;
        if (districtDataJson != null) {
          DistrictData districtData = DistrictData.fromJson(districtDataJson);
          print("districtName ${districtData.name}");
          state =AsyncValue.data(districtData.name);
          await fireStore.collection('users').doc(userId).update({'district': districtData.name});
          return districtData.name;
        } else {
          return "";
        }

      } else {
        return "";
      }

    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
      return '';
    }
  }
}