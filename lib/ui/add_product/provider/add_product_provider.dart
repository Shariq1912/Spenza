import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/data/user_product_insert.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_provider.g.dart';

@riverpod
class AddProduct extends _$AddProduct
    with NearbyStoreMixin, FirestoreAndPrefsMixin {
  @override
  Future<List<Product>> build() async {
    return [];
  }

  /// Main searching Algorithm
  Future<void> searchProducts({String query = "Tomate"}) async {
    // Available Products
    // Papel Aluminio Reynolds Wrap 20 m,
    // Jabon de tocador Lirio dermatologico 5 pzas de 120 g c/u,
    // Detergente liquido Bold 3 carinitos de mama 4.23 l
    // Ketchup Heinz 397 g

    List<Product> searchResults = [];
    List<DocumentReference> nearbyStoreRefs = [];

    try {
      state = AsyncValue.loading();

      final nearbyStores = await getNearbyStores(
        firestore: fireStore,
        userLocation: GeoPoint(20.68016662, -103.3822084),
      );

      nearbyStores.forEach(
        (element) => nearbyStoreRefs.add(
          fireStore.collection('stores').doc(element.id),
        ),
      );

      query = query.isEmpty ? "Tomate" : query.toLowerCase();

      QuerySnapshot snapshot = await fireStore
          .collection('products_mvp')
          .where('storeRef', whereIn: nearbyStoreRefs)
          .where('is_exist', isEqualTo: true)
          .get();

      for (var value in snapshot.docs) {
        DocumentSnapshot valueSnapshot = value;
        try {
          print("ADD PRODUCT DATA = ${value.data()}");

          final Product product = Product.fromDocument(value);

          var hasGenericNameMatched = product.genericNames.any((genericName) =>
              genericName.toLowerCase().contains(query.toLowerCase()));

          if (hasGenericNameMatched ||
              product.name.toLowerCase().contains(query.toLowerCase())) {
            searchResults.add(product);
          }
        } catch (e) {
          print('Error processing value: ${valueSnapshot.data()}');
          print('Error details: $e');
        }
      }

      /*searchResults.forEach(
        (element) => print(
          "ID : ${element.productId} == Product Name : ${element.name} == Store : ${element.storeRef} == Department Name : ${element.department} == Price : ${element.minPrice} == GenericNames : ${element.genericNames.toString()}",
        ),
      );*/

      final List<Product> filteredList = [];

      /// Works only if list sorted by product whose genericNames similar
      if (searchResults.isNotEmpty) {
        Product selectedProduct = searchResults.first;
        double minPrice = double.parse(selectedProduct.minPrice);
        double maxPrice = double.parse(selectedProduct.minPrice);

        for (var i = 1; i < searchResults.length; i++) {
          Product product = searchResults[i];

          bool isSimilarProduct = selectedProduct.measure == product.measure &&
              selectedProduct.department == product.department &&
              selectedProduct.genericNames
                  .toSet()
                  .containsAll(product.genericNames.toSet());

          if (isSimilarProduct) {
            double productMinPrice = double.parse(product.minPrice);
            minPrice = min(minPrice, productMinPrice);
            maxPrice = max(maxPrice, productMinPrice);
          } else {
            Product filteredProduct = selectedProduct.copyWith(
              minPrice: minPrice.toString(),
              maxPrice: maxPrice.toString(),
            );
            filteredList.add(filteredProduct);

            /// Reset selected Product to the current loop element and same for min and max price
            selectedProduct = product;
            minPrice = double.parse(product.minPrice);
            maxPrice = double.parse(product.minPrice);
          }
        }

        /// Last selected product will not be able to added list due to loop ended so handled outside
        Product filteredProduct = selectedProduct.copyWith(
          minPrice: minPrice.toString(),
          maxPrice: maxPrice.toString(),
        );
        filteredList.add(filteredProduct);
      }

      print('Filter List: ${filteredList.toString()}');

      state = AsyncValue.data(filteredList);
    } on FirebaseException catch (e) {
      if (e.code == 'no-internet') {
        print('No internet connection. Please check your network.');
      } else {
        print('Firestore exception: ${e.message}');
      }
      state = AsyncValue.error(
          'Error searching products: ${e.message}', StackTrace.current);
    } catch (e) {
      print('Error searching products: $e');
      state =
          AsyncValue.error('Error searching products: $e', StackTrace.current);
    }
  }

  /// Add The selected product in user my list
  Future<void> addProductToUserList(BuildContext context,
      {required Product product}) async {
    try {
      final userListId = await prefs.then((prefs) => prefs.getUserListId());

      print(userListId);

      CollectionReference userProductList = fireStore
          .collection(MyList.collectionName)
          .doc(userListId)
          .collection(UserProductListCollection.collectionName);

      final query = await userProductList
          .where(ProductCollectionConstant.productId,
              isEqualTo: product.productId)
          .limit(1)
          .get();

      var isProductExist = query.docs.isNotEmpty;

      if (isProductExist) {
        context.showSnackBar(message: "Product Already Exist in the List");
        return;
      }

      final userProduct = UserProductInsert(
          productRef: fireStore
              .collection(ProductCollectionConstant.collectionName)
              .doc(product.productRef),
          productId: product.productId);

      userProductList
          .add(userProduct.toJson())
          .then((value) => context.pop(true));
    } on FirebaseException catch (e) {
      if (e.code == 'no-internet') {
        print('No internet connection. Please check your network.');
      } else {
        print('Firestore exception: ${e.message}');
      }
      context.showSnackBar(message: 'Firestore exception: ${e.message}');
    } catch (e) {
      print('Error adding product to user list: $e');
      context.showSnackBar(message: 'Error adding product to user list: $e');
    }
  }

  /// Not much useful
  Future<void> findNearbyLocations() async {
    Future.delayed(Duration.zero);

    try {
      // Query for "Akota Garden" location
      QuerySnapshot querySnapshot = await fireStore
          .collection('locations')
          .where('place_name', isEqualTo: 'Akota Garden')
          .get();

      // Get the first document from the query result
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Get the coordinates of "Akota Garden"
      GeoPoint akotaGardenLocation = documentSnapshot['coordinates'];

      // Create a GeoFirePoint for "Akota Garden"
      GeoFirePoint center = GeoFirePoint(akotaGardenLocation);

      // Reference to locations collection.
      final CollectionReference<Map<String, dynamic>> locationCollectionRef =
          fireStore.collection('locations');

      // Get the documents within a 3 km radius of "Akota Garden"
      final result =
          await GeoCollectionReference(locationCollectionRef).fetchWithin(
        center: center,
        radiusInKm: 3,
        field: 'geo',
        strictMode: true,
        geopointFrom: geopointFrom,
      );

      for (var value in result) {
        String placeName = value['place_name'];
        final distance =
            center.distanceBetweenInKm(geopoint: value['coordinates']);

        print(placeName);
        print("Distance : $distance");
      }
    } catch (e) {
      print("ERROR IN LOCATION : $e");
    }
  }
}
