import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/login/data/login_request.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spenza/ui/login/data/user.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class FavoriteRepository extends StateNotifier<ApiResponse> {
  FavoriteRepository() : super(const ApiResponse());

  Future<List<DocumentSnapshot>> fetchNearbyStores() async {
    final pref = await SharedPreferences.getInstance();
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(pref.getUserId())
        .get();

    GeoPoint location = document.data()!['location'];

    /*final geo = GeoFlutterFire();
    // Create a GeoFirePoint from the provided latitude and longitude
    GeoFirePoint center =
        // geo.point(latitude: location.latitude, longitude: location.longitude);
        geo.point(latitude: 20.72287011, longitude: -103.415378);
    // 20.72287011, -103.415378

    // Get the Firestore CollectionReference for the "stores" collection
    final collectionRef = FirebaseFirestore.instance.collection('stores');

    // Fetch nearby stores using the "location" field and provided radius
    List<DocumentSnapshot> nearbyStores = await geo
        .collection(collectionRef: collectionRef)
        .within(
          center: center,
          radius: 5000,
          field: 'location',
        )
        .first;

    debugPrint("Favourite data is $nearbyStores");*/

    final collectionRef = FirebaseFirestore.instance.collection('stores');

// Get all documents in the "stores" collection.
    QuerySnapshot querySnapshot = await collectionRef.get();

  // Iterate over the documents and print their fields.
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      debugPrint("Document: ${documentSnapshot.id}");
      debugPrint(documentSnapshot.data() as String?);
    }

    // state = ApiResponse.success(data: collectionRef);

    return [];
    // return nearbyStores;
  }
}
