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
import "package:collection/collection.dart";

part 'add_product_provider.g.dart';

@riverpod
class AddProduct extends _$AddProduct
    with LocationHelper, NearbyStoreMixin, FirestoreAndPrefsMixin {
  final Set<String> removedProducts = Set();

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
        context.showSnackBar(message: "Product already exist in the List");
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

  /// Increase quantity in the product
  Future<void> increaseQuantity({required Product product}) async {
    final List<Product>? products = state.requireValue;
    if (products == null || products.isEmpty) {
      return;
    }

    final index = products.indexOf(product);
    if (index != -1) {
      if (removedProducts.contains(product.productRef))
        removedProducts.remove(product.productRef);

      products[index] = product.copyWith(quantity: product.quantity + 1);
    }

    state = AsyncValue.data(products);
  }

  /// Decrease quantity in the product
  Future<void> decreaseQuantity({required Product product}) async {
    final List<Product>? products = state.requireValue;
    if (products == null || products.isEmpty || product.quantity == 0) {
      return;
    }

    final index = products.indexOf(product);
    if (index != -1) {
      if (product.quantity == 1) removedProducts.add(product.productRef);
      products[index] = product.copyWith(quantity: product.quantity - 1);
    }

    state = AsyncValue.data(products);
  }

  Future<void> saveUserSelectedProductsToDB() async {
    // Fetch products from the current state that have a quantity greater than 1
    final List<Product>? products = state.requireValue;
    if (products == null || products.isEmpty) {
      return;
    }

    final productsToSave =
        products.where((product) => product.quantity > 0).toList();

    // Remove products that are in the removedProducts set
    final productsToRemove = products
        .where((product) => removedProducts.contains(product.productRef))
        .toList();

    final batch = fireStore.batch();
    final userListId = await prefs.then((prefs) => prefs.getUserListId());
    final productDocumentMap = Map<String, String>();
    final removedProductDocumentMap = Map<String, String>();
    final myListRef =
        fireStore.collection(MyListConstant.myListCollection).doc(userListId);

    if (productsToSave.isNotEmpty) {
      // Use a collection group query to query the user_product_list subcollection based on product_ref
      final querySnapshot = await myListRef
          .collection('user_product_list')
          .where(
            'product_ref',
            whereIn: productsToSave
                .map(
                  (product) => fireStore
                      .collection(ProductCollectionConstant.collectionName)
                      .doc(product.productRef),
                )
                .toList(),
          )
          .get();

      for (var result in querySnapshot.docs) {
        final Map<String, dynamic> data = result.data();
        productDocumentMap[data['product_ref'].id.toString()] = result.id;
        print(
            "To Be Save collection DATA ::: ${productDocumentMap.toString()} and ${result.id}");
      }
    }

    if (productsToRemove.isNotEmpty) {
      // Use a collection group query to query the user_product_list subcollection based on product_ref
      final querySnapshot = await myListRef
          .collection('user_product_list')
          .where(
            'product_ref',
            whereIn: productsToRemove
                .map(
                  (product) => fireStore
                      .collection(ProductCollectionConstant.collectionName)
                      .doc(product.productRef),
                )
                .toList(),
          )
          .get();

      for (var result in querySnapshot.docs) {
        final Map<String, dynamic> data = result.data();
        removedProductDocumentMap[data['product_ref'].id.toString()] =
            result.id;
        print(
            "To Be Delete collection DATA ::: ${removedProductDocumentMap.toString()} and ${result.id}");
      }
    }

    for (final product in productsToSave) {
      String? existingDocId = productDocumentMap[product.productRef];
      print(
          "To Be SAVED existingDocId ::: $existingDocId and REF AGAINST == ${product.productRef}");

      DocumentReference documentRef;

      if (existingDocId != null) {
        // If the key exists, use the existing document
        documentRef =
            myListRef.collection('user_product_list').doc(existingDocId);
      } else {
        // If the key does not exist, create a new document
        documentRef = myListRef.collection('user_product_list').doc();
      }

      final userProduct = UserProductInsert(
        productRef: fireStore
            .collection(ProductCollectionConstant.collectionName)
            .doc(product.productRef),
        productId: product.productId,
        quantity: product.quantity,
      );

      batch.set(documentRef, userProduct.toJson());
    }

    removedProductDocumentMap.values.forEach((element) {
      print("To Be DELETED documentId ::: $element");

      final documentRef =
          myListRef.collection('user_product_list').doc(element);
      batch.delete(documentRef);
    });

    try {
      await batch.commit();
    } catch (e) {
      // Handle any Firestore commit errors
      print('Error saving user selected products: $e');
    }
  }
}
