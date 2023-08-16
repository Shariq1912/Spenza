import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/profile/data/district_data.dart';
import 'package:spenza/ui/profile/data/user_profile_data.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'profile_repository.g.dart';

@riverpod
class ProfileRepository extends _$ProfileRepository {
  @override
  ApiResponse build() {
    return ApiResponse();
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserProfileData?> getUserProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    try {
      state = ApiResponse.loading();
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _fireStore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        state = ApiResponse.success(
            data: UserProfileData.fromJson(snapshot.data()!));
        print("resss ${snapshot.data()}");
        return UserProfileData.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      debugPrint("Error fetching user data: $error");
      return null;
    }
  }
/*
  Future<bool> saveZipCodeToServer(UserProfileData userProfileData, File? image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getUserId();
    state = ApiResponse.loading();
    String? downloadURL;
    if (image != null) {
      downloadURL = await image.uploadImageToFirebase( path: "profilePictures");
    }

    final Map<String, dynamic> userData = userProfileData.copyWith(profilePhoto: downloadURL).toJson();

    userData.entries.forEach((element) {
      print("userDaa ${element.value}");
    });


    if (userProfileData.zipCode.isEmpty) {
      final userProfileDataFromDb = await getUserProfileData();
      if (userProfileDataFromDb != null) {
        userData['zipCode'] = userProfileDataFromDb.zipCode;
      }
    }



    try {
      String districtName = await fetchDistrictNameFromZipcode(int.parse(userProfileData.zipCode));
      userData['district'] = districtName;

      DistrictData stateData = await fetchStateNameFromZipcode(int.parse(userProfileData.zipCode));
      userData['state'] = stateData.name;
      userData.entries.forEach((element) {
        print("userDaaIn ${element.value}");
      });
      await _fireStore.collection('users').doc(userId).update(userData);
      return true;
    } catch (error) {
      debugPrint("$error");
      state = ApiResponse.error(errorMsg: error.toString());
      return false;
    }
  }

  Future<String> fetchDistrictNameFromZipcode(int zipcodeValue) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    try {
      QuerySnapshot querySnapshot = await _fireStore
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
          await _fireStore.collection('users').doc(userId).update({'district': districtData.name});
          return districtData.name;
        } else {
          return "";
        }
      } else {
        return "";
      }
    } catch (error) {
     state = ApiResponse.error(errorMsg: error.toString());
      print("Error fetching district data: $error");
      return "";
    }
  }

  Future<DistrictData> fetchStateNameFromZipcode (int zipcodeValue) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getUserId();
    try{
      //state =ApiResponse.loading();
      QuerySnapshot querySnapshot = await _fireStore
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
          await _fireStore.collection('users').doc(userId).update({'state': districtData.name});
          //state =ApiResponse.success(data: districtData);
          return districtData;
        } else {
          return DistrictData(name: '');
        }
      } else {
        return DistrictData(name: '');
      }
    } catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
      print("Error fetching district data: $error");
      return DistrictData(name: '');
    }
    }*/

  /*Future<void> rankStoresByPriceTotal(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    // User ID (you can replace this with the actual user ID)
    String userId = "rbUVwnV1rpcTAOGyTv0ZyMDANsM2";

    try {
      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await _fireStore
          .collection('mylist')
          .doc(listId)
          .collection('user_product_list')
          .get();

      // Initialize a map to store the total price for each store
      Map<String, double> storeTotalPrices = {};

      // Create a list of store IDs to query the prices subcollection
      List storeIds = productListSnapshot.docs.map((productSnapshot) {
        return productSnapshot['idStore'];
      }).toList();

      // Fetch the prices for all the products in the user's product list
      *//*QuerySnapshot<Map<String, dynamic>> productPricesSnapshot =
      await _fireStore
          .collectionGroup('prices')
      // .where('idStore', whereIn: storeIds)
          //.where('storeName', isEqualTo: "Cool Store")
          .get();*//*


     *//* QuerySnapshot productPricesSnapshot = await FirebaseFirestore.instance
          .collection('products_clone')
          .get();

      Map<String, Object> productPricesByStore = {};

      for (QueryDocumentSnapshot docSnapshot in productPricesSnapshot.docs) {
        String productId = docSnapshot.id;

        QuerySnapshot pricesSnapshot = await FirebaseFirestore.instance
            .collection('products_clone')
            .doc(productId)
            .collection("prices")
            .get();

        pricesSnapshot.docs.forEach((priceSnapshot) {
          productPricesByStore[productId] = priceSnapshot.data()!;
        });
      }*//*
      Map<String, Object> productPricesByStore = {};

      QuerySnapshot pricesSnapshot = await FirebaseFirestore.instance
          .collectionGroup("prices")
          .get();
      pricesSnapshot.docs.forEach((priceSnapshot) {
        String productId = priceSnapshot.reference.parent.parent?.id ?? "";

        // Store the data in the productPricesByStore map
        productPricesByStore[productId] = priceSnapshot.data()!;
      });

      print("priccc : ${productPricesByStore.toString()}");



      // You can now use the sortedStores list to display the stores to the user.
    } catch (e) {
      print('Error ranking stores: $e');
    }
  }*/



}
