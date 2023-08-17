import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/profile/data/user_profile_data.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'user_profile_data.g.dart';

@riverpod
class UserProfileDatas extends _$UserProfileDatas with FirestoreAndPrefsMixin {


  @override
  FutureOr<UserProfileData> build() async{
    try{
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());
      final DocumentSnapshot<Map<String, dynamic>> snapShot = await fireStore.collection(UserConstant.userCollection).doc(userId).get();
      //final List<UserProfileData> userData = snapShot.

      if(snapShot.exists){
        final data = UserProfileData.fromJson(snapShot.data()!);
        state = AsyncValue.data(data);
        return data;
      }
    return UserProfileData.fromJson(snapShot.data()!);
    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
      return UserProfileData(zipCode: "");
    }

  }

  Future<void> getUserProfileData() async {
    try{
      state = AsyncValue.loading();

      final userId = await prefs.then((prefs) => prefs.getUserId());
      final DocumentSnapshot<Map<String, dynamic>> snapShot = await fireStore.collection(UserConstant.userCollection).doc(userId).get();
      //final List<UserProfileData> userData = snapShot.

      if(snapShot.exists){
        final data = UserProfileData.fromJson(snapShot.data()!);
        state = AsyncValue.data(data);
      }

    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
    }
  }
}