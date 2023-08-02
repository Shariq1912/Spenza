import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/my_list_details/data/similar_product_matcher.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'user_product_list_provider.g.dart';

@riverpod
class UserProductList extends _$UserProductList {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late SharedPreferences _prefs;

  @override
  Future<List<UserProduct>> build() async {
    _prefs = await SharedPreferences.getInstance();
    return [];
  }

  Future<void> fetchProductFromListId(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    state = AsyncValue.loading();

    try {
      final productListRef = _fireStore
          .collection(MyList.collectionName)
          .doc(listId)
          .collection(UserProductListCollection.collectionName);

      final List<UserProduct> productList = [];
      productListRef.snapshots().listen((event) async {
        productList.clear();
        for (var snapshot in event.docs) {
          final DocumentReference productRef =
              snapshot[ProductCollectionConstant.productId];
          final DocumentSnapshot<Object?> data = await productRef.get();

          final genericNames = (data['genericNames'] as List<dynamic>)
              .map((name) => name.toString().toLowerCase())
              .toSet()
              .toList();

          _findPriceRangeFromGenericNames(genericNames);


           productList.add(UserProduct(
            productId: productRef.id,
            department: data['department_name'],
            name: data['name'],
            minPrice: "minPrice".toString(),
            maxPrice: "maxPrice".toString(),
            quantity: snapshot['quantity'],
            pImage: data['pImage'],
            measure: data['measure'] == "kg" ? "1 kg" : data['measure'],
          ));
        }

        print(productList.toString());
        state = AsyncValue.data(productList);
      });
    } catch (e) {
      print('Error fetching Product List: $e');
    }
  }

  _findPriceRangeFromGenericNames(List<String> genericNames){

  }

  Future<void> updateUserProductList(
      {required UserProduct product, required int quantity}) async {
    final List<UserProduct> data = state.requireValue;
    final index = data.indexOf(product);
    if (index != -1) {
      data[index] = product.copyWith(quantity: quantity);
    }

    state = AsyncValue.data(data);
  }

  Future<void> deleteProductFromUserList({
    required UserProduct product,
    required String listId,
  }) async {
    // Fetch the user's product list from the user_product_list subcollection
    QuerySnapshot snapshot = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .where(
          ProductCollectionConstant.productId,
          isEqualTo: _fireStore.getDocumentReferenceFromString(
            collectionName: ProductCollectionConstant.collectionName,
            id: product.productId,
          ),
        )
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();

      /*final data = state.requireValue;
      data.remove(
          data.firstWhere((element) => element.idStore == product.idStore));
      state = AsyncValue.data(data);*/
    }
  }

  Future<void> saveUserProductListToServer(
      {String listId = "4NlYnhmchdlu528Gw2yK",
      required BuildContext context}) async {
    final List<UserProduct> data = state.requireValue;
    final userProductsCollection = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    userProductsCollection.docs.forEach((doc) {
      final UserProduct matchingElement = data.firstWhere(
        (element) =>
            doc['product_id'] ==
            _fireStore.getDocumentReferenceFromString(
              collectionName: ProductCollectionConstant.collectionName,
              id: element.productId,
            ),
      );
      batch.update(doc.reference, {'quantity': matchingElement.quantity});
    });

    await batch.commit();

    print("Data Updated Successfully");

    // context.goNamed(RouteManager.storeMatchingScreen);
  }

  Future<void> rankStoresByPriceTotal(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    try {
      Map<String, int> productQuantity = {};
      Map<DocumentReference, double> storeTotalPrices =
          {}; // Initialize a map to store the total price for each store
      Map<String, String?> originalSimilarMap = {};
      Map<String, bool> isProductExist = {};

      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await _fireStore
          .collection('mylist')
          .doc(listId)
          .collection('user_product_list')
          .get();

      // Create a list of store IDs to query the prices subcollection
      List<String> idStores = productListSnapshot.docs.map((element) {
        final idStore = element['idStore'] as String;
        productQuantity[idStore] = element['quantity'];
        isProductExist[idStore] = true;
        return idStore;
      }).toList();

      final missingProductsIdStores =
          await _getMissingProductsIdStores(idStores, isProductExist);

      missingProductsIdStores.forEach((product) {
        /// Key = Original and Value = similar or original if similar null
        originalSimilarMap[product.originalIdStore] = product.similarIdStore;

        // print('Original: ${product.originalIdStore}, Similar: ${product.similarIdStore}');
      });

      /*isProductExist.forEach((id, isExist) {
        print('Product: $id, Is Exist: $isExist');
      });*/

      for (String id in idStores) {
        var similarProductId = id;

        /// if original missing then fetch from similar
        if (!isProductExist[id]!) {
          similarProductId = originalSimilarMap[id]!;
        }

        final QuerySnapshot productPricesSnapshot = await _fireStore
            .collection('products_clone')
            .doc(similarProductId)
            .collection('prices')
            .get();

        /// Increase missing + 1 product here .....

        final quantity = productQuantity[id] ?? 0;

        productPricesSnapshot.docs.forEach((element) {
          // print("$element['storeName'] and $element['price']");

          // String storeName = element['storeName'].toString();
          final storeRef = element['storeRef'];
          final price = (element['price'] as num).toDouble();

          storeTotalPrices[storeRef] =
              (storeTotalPrices[storeRef] ?? 0) + (quantity * price);
        });
      }
      List<MatchingStores> stores = [];

      for (MapEntry<DocumentReference<Object?>, double> entry
          in storeTotalPrices.entries) {
        print(
            'Store: ${entry.key}, Total Price: ${entry.value.toPrecision(2)}');
        final store = await _getStoreFromPath(entry.key.path);
        stores.add(store);
      }

      stores..sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
      print('stores are: $stores');
    } catch (e) {
      print('Error ranking stores: $e');
    }
  }

  Future<MatchingStores> _getStoreFromPath(String path) async {
    DocumentSnapshot storeSnapshot =
        await FirebaseFirestore.instance.doc(path).get();

    GeoPoint location = storeSnapshot['location'] as GeoPoint;

    return MatchingStores(
      logo: storeSnapshot['logo'],
      name: storeSnapshot['name'],
      totalPrice: 0,
      location: location.getLocationString(),
      address: storeSnapshot[
          'adress'], //todo change the typo address once field changed in db
    );
  }

  Future<List<SimilarProductMatcher>> _getMissingProductsIdStores(
      var idStores, Map<String, bool> isProductExist) async {
    /// Will use these ids to fetch similar product from our products using some matching criteria.
    final productListNotExistSnapshot = await _fireStore
        .collection('products_clone')
        .where('idStore', whereIn: idStores)
        .where('is_exist', isEqualTo: false)
        .get();

    final List<SimilarProductMatcher> productList = [];

    for (final snapShot in productListNotExistSnapshot.docs) {
      final idStore = snapShot['idStore'].toString();

      final departments = snapShot['departments'];
      final genericNames = snapShot['genericNames'];
      final measure = snapShot['measure'].toString();

      final productListNotExistSnapshot = await _fireStore
          .collection('products_clone')
          .where('is_exist', isEqualTo: true)
          .where('departments', isEqualTo: departments)
          .where('genericNames', isEqualTo: genericNames)
          .where('measure', isEqualTo: measure)
          .get();

      var isExist = false;
      for (var element in productListNotExistSnapshot.docs) {
        final newIdStore = element['idStore'].toString();
        isExist = true;
        productList.add(
          SimilarProductMatcher(
            originalIdStore: idStore,
            similarIdStore: newIdStore,
          ),

          /// Replacement of original product
        );
        break;
      }

      if (!isExist) {
        productList.add(
          SimilarProductMatcher(originalIdStore: idStore, similarIdStore: null),
        );
      }

      isProductExist[idStore] = false;
    }

    return productList;
  }

  Future<void> rankStoresByPriceTotal2(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    // User ID (you can replace this with the actual user ID)
    String userId = "rbUVwnV1rpcTAOGyTv0ZyMDANsM2";

    try {
      // Fetch the prices for all the products in the user's product list
      Map<String, int> productQuantity = {};

      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await _fireStore
          .collection('mylist')
          .doc(listId)
          .collection('user_product_list')
          .get();

      // Create a list of store IDs to query the prices subcollection
      List<String> idStores = productListSnapshot.docs.map((element) {
        final idStore = element['idStore'].toString();
        productQuantity[idStore] = element['quantity'];
        return idStore;
      }).toList();

      QuerySnapshot productPricesSnapshot = await _fireStore
          .collectionGroup('prices')
          .where('idStore', whereIn: idStores)
          .get();

      productPricesSnapshot.docs.forEach((priceSnapshot) {
        print(priceSnapshot['price']);
      });
    } catch (e) {
      print('Error ranking stores: $e');
    }
  }

/*Future<void> rankStoresByPriceTotal({String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    // User ID (you can replace this with the actual user ID)
    String userId = "rbUVwnV1rpcTAOGyTv0ZyMDANsM2";

    try {
      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await FirebaseFirestore.instance
          .collection('mylist')
          .doc(listId)
          .collection('user_product_list')
          .get();

      // Initialize a map to store the total price for each store
      Map<String, double> storeTotalPrices = {};

      // Create a list of store IDs to query the prices subcollection
      List<String> storeIds = productListSnapshot.docs.map((productSnapshot) {
        return productSnapshot['idStore'] as String;
      }).toList();

      // Fetch the prices for all the products in the user's product list using collectionGroup
      for (String storeId in storeIds) {
        QuerySnapshot<Map<String, dynamic>> productPricesSnapshot = await FirebaseFirestore.instance
            .collection('products_clone')
            .doc(storeId) // Assuming storeId is the document ID of products_clone
            .collection('prices')
            .get();

        // Loop through the prices subcollection for the current storeId
        productPricesSnapshot.docs.forEach((priceSnapshot) {
          // Get the product price data
          Map<String, dynamic> productPriceData = priceSnapshot.data();

          // You can now process the productPriceData as needed.
          // For example, you can calculate the total price for the product (price * quantity).

          // Sample calculation:
          double price = productPriceData['price'] ?? 0;
          double quantity = productPriceData['quantity'] ?? 0;
          double totalPrice = price * quantity;

          // Add the total price to the storeTotalPrices map
          storeTotalPrices[storeId] = (storeTotalPrices[storeId] ?? 0) + totalPrice;
        });
      }

      // Sort the stores based on their total price in ascending order (lowest price total first)
      List<MapEntry<String, double>> sortedStores = storeTotalPrices.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      // Display the sorted stores
      sortedStores.forEach((entry) {
        String storeId = entry.key;
        double totalPrice = entry.value;
        print('Store ID: $storeId, Total Price: $totalPrice');
      });

      // You can now use the sortedStores list to display the stores to the user.

    } catch (e) {
      print('Error ranking stores: $e');
    }
  }*/
}
