import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../data/district_data.dart';
import '../data/user_profile_data.dart';

part 'save_zipcode.g.dart';

@riverpod
class SaveUserData extends _$SaveUserData with FirestoreAndPrefsMixin{
  @override
  FutureOr<void> build(){
  }

  Future<void> saveZipCodeToServer(UserProfileData userProfileData, File? image, BuildContext  context) async {
    try{
      state = AsyncValue.loading();

      final SharedPreferences pref = await SharedPreferences.getInstance();
      final userId = await prefs.then((prefs) => prefs.getUserId());
      final postalCode = await prefs.then((prefs) => prefs.getPostalCode());
      print("postal codes : $postalCode");

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase( path: "profilePictures");
      }
      final Map<String, dynamic> userData = userProfileData.copyWith(profilePhoto: downloadURL).toJson();

      if (userProfileData.zipCode.isEmpty){
        /*final userProfileDataFromDb = await ref.read(profileRepositoryProvider.notifier).getUserProfileData();
        if (userProfileDataFromDb != null) {
          userData['zipCode'] = userProfileDataFromDb.zipCode;
        }*/
        print("postal codes : empty");
        userData['zipCode'] = postalCode;
        print("postal codes :  ${userData['zipCode']}");
      }
      try {
        String districtName = '';
        DistrictData stateData = DistrictData(name: '');
      if (userProfileData.zipCode.isNotEmpty) {
        await pref.setString(UserConstant.zipCodeField, postalCode);
         districtName = await fetchDistrictNameFromZipcode(int.parse(userProfileData.zipCode));
          stateData = await fetchStateNameFromZipcode(int.parse(userProfileData.zipCode));
      } else {
         districtName = await fetchDistrictNameFromZipcode(int.parse(postalCode));
          stateData = await fetchStateNameFromZipcode(int.parse(postalCode));
      }

        userData['district'] = districtName;
        userData['state'] = stateData.name;
        userData.entries.forEach((element) {
          print("userDaaIn ${element.value}");
        });
        await fireStore.collection('users').doc(userId).update(userData);
      } catch (error,stackTrace) {
        debugPrint(" error $error");
        state = AsyncValue.error(error, stackTrace);
      }
      state = AsyncValue.data(userData);
      context.pop(RouteManager.profileScreen);
      context.pushReplacement(RouteManager.profileScreen);
    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<String> fetchDistrictNameFromZipcode(int zipcodeValue) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    try {
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
          //state =ApiResponse.success(data: districtData);
          await fireStore.collection('users').doc(userId).update({'district': districtData.name});
          return districtData.name;
        } else {
          return "";
        }
      } else {
        return "";
      }
    } catch (error,stackTrace) {
      state = AsyncValue.error(error,stackTrace);
      print("Error fetching district data: $error");
      return "";
    }
  }

  Future<DistrictData> fetchStateNameFromZipcode (int zipcodeValue) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    try{
      QuerySnapshot querySnapshot = await fireStore
          .collection('zipcodes')
          .where('zipcode', isEqualTo: zipcodeValue)
          .get();

      DocumentSnapshot zipcodeDocument = querySnapshot.docs.first;
      DocumentReference districtRef = zipcodeDocument.get('stateRef');
      DocumentSnapshot districtSnapshot = await districtRef.get();

      if (districtSnapshot.exists) {
        Map<String, dynamic>? districtDataJson =
        districtSnapshot.data() as Map<String, dynamic>?;
        if (districtDataJson != null) {
          DistrictData districtData = DistrictData.fromJson(districtDataJson);
          print("stateName ${districtData.name}");
          await fireStore.collection('users').doc(userId).update({'state': districtData.name});

          return districtData;
        } else {
          return DistrictData(name: '');
        }
      } else {
        return DistrictData(name: '');
      }
    } catch (error,stackTrace) {
      state = AsyncValue.error(error,stackTrace);
      print("Error fetching district data: $error");
      return DistrictData(name: '');
    }
  }
}