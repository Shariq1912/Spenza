import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/helpers/location_helper.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/data/user_product_insert.dart';
import 'package:spenza/ui/add_product/provider/search_product_repository_provider.dart';
import 'package:spenza/ui/add_product/repository/search_product_repository.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_provider.g.dart';

@riverpod
class AddProduct extends _$AddProduct
    with LocationHelper, NearbyStoreMixin, FirestoreAndPrefsMixin {
  @override
  Future<List<Product>?> build() async {
    return null;
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
      final userId = await prefs.then((prefs) => prefs.getUserId());

      // GeoPoint? location = await getCurrentLocation();
      GeoPoint? location;

      if (location == null) {
        location = await getLocationByZipCode(
          await getUserZipCodeFromDB(
            fireStore,
            userId,
          ), // Get Zip code from Shared Pref.
        );
      }

      final nearbyStores = await getNearbyStores(
        firestore: fireStore,
        userLocation: location,
      );

      if (nearbyStores.isEmpty) {
        // Where in requires non empty iterator.
        state = AsyncValue.error("No nearby stores found!", StackTrace.empty);
        return;
      }

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
          // print("ADD PRODUCT DATA = ${value.data()}");

          final Product product = Product.fromDocument(value);

          final hasGenericNameMatched = product.genericNames.any((genericName) {
            final words = query.toLowerCase().split(" ");
            return words.any((word) => word == genericName.toLowerCase());
          });

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

      // Group similar products by a unique identifier, e.g., based on measure, department, and generic names
      final Map<String, List<Product>> productGroups = {};

      for (var product in searchResults) {
        final key =
            "${product.measure}-${product.department}-${product.genericNames.join('-')}";

        if (!productGroups.containsKey(key)) {
          productGroups[key] = [product];
        } else {
          productGroups[key]!.add(product);
        }
      }

      // Calculate the price range for each group of similar products
      final List<Product> filteredList = [];

      productGroups.forEach((key, group) {
        double minPrice = double.parse(group.first.minPrice);
        double maxPrice = double.parse(group.first.minPrice);

        for (var product in group) {
          double productMinPrice = double.parse(product.minPrice);
          minPrice = min(minPrice, productMinPrice);
          maxPrice = max(maxPrice, productMinPrice);
        }

        // Create a new product with the calculated price range
        final filteredProduct = group.first.copyWith(
          minPrice: minPrice.toString(),
          maxPrice: maxPrice.toString(),
        );

        filteredList.add(filteredProduct);
      });

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

  Future<void> searchProductsNew({
    required String query,
    required CancelToken cancelToken,
  }) async {
    try {
      state = AsyncValue.loading();
      final userId = await prefs.then((prefs) => prefs.getUserId());

      // GeoPoint? location = await getCurrentLocation();
      GeoPoint? location;

      location = await getLocationByZipCode(
        await getUserZipCodeFromDB(
          fireStore,
          userId,
        ), // Get Zip code from Shared Pref.
      );

      print("${location.latitude}");

      final nearbyStores = await getNearbyStores(
        firestore: fireStore,
        userLocation: location,
      );

      if (nearbyStores.isEmpty) {
        // Where in requires non empty iterator.
        state = AsyncValue.error("No nearby stores found!", StackTrace.empty);
        return;
      }

      final nearbyStoreIds = nearbyStores
          .map(
            (element) => element.id,
          )
          .toList();

      try {
        final List<Product> products = await ref
            .read(searchProductRepositoryProvider)
            .searchProductRepository(
              storeIds: nearbyStoreIds,
              query: query.toLowerCase(),
              cancelToken: cancelToken,
            );

        state = AsyncValue.data(products);
      } on DioException catch (e) {
        print('Error searching products due to DIO EXCEPTION: $e');
        state = AsyncValue.error(
            'Error searching products: $e', StackTrace.current);
      } catch (e) {
        print('Error searching products : $e');
        state = AsyncValue.error(
            'Error searching products: $e', StackTrace.current);
      }
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
