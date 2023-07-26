import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
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
      final productListRef = await _fireStore
          .collection(MyList.collectionName)
          .doc(listId)
          .collection(UserProductListCollection.collectionName)
          .get();

      final productList = productListRef.docs
          .map(
            (data) => UserProduct(
              idStore: data['idStore'],
              department: data['department'],
              name: data['name'],
              minPrice: data['minPrice'].toString(),
              maxPrice: data['maxPrice'].toString(),
              quantity: data['quantity'],
              pImage: data['pImage'],
              measure: data['measure'],
            ),
          )
          .toList();

      print(productList.toString());
      state = AsyncValue.data(productList);
    } catch (e) {
      print('Error fetching Product List: $e');
    }
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

  Future<void> saveUserProductListToServer(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    final List<UserProduct> data = state.requireValue;
    final userProductsCollection = await _fireStore
        .collection(MyList.collectionName)
        .doc(listId)
        .collection(UserProductListCollection.collectionName)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    userProductsCollection.docs.forEach((doc) {
      final UserProduct matchingElement =
          data.firstWhere((element) => element.idStore == doc['idStore']);
      batch.update(doc.reference, {'quantity': matchingElement.quantity});
    });

    await batch.commit();

    print("Data Updated Successfully");
  }

  Future<void> rankStoresByPriceTotal2(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    // User ID (you can replace this with the actual user ID)
    String userId = "rbUVwnV1rpcTAOGyTv0ZyMDANsM2";

    try {
      Map<String, int> productQuantity = {};
      Map<String, double> storeTotalPrices =
          {}; // Initialize a map to store the total price for each store

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
        return idStore;
      }).toList();

      final missingProductsIdStores =
          await _getMissingProductsIdStores(idStores);

      /*final productSnapshot = await FirebaseFirestore.instance
          .collection('products_clone')
          .where('idStore', whereIn: idStores)
          .where('is_exist', isEqualTo: true)
          .get();*/

      for (String id in idStores) {
        final QuerySnapshot productPricesSnapshot = await _fireStore
            .collection('products_clone')
            .doc(id)
            .collection('prices')
            .get();

        final quantity = productQuantity[id] ?? 0;

        productPricesSnapshot.docs.forEach((element) {
          // print("$element['storeName'] and $element['price']");

          String storeName = element['storeName'].toString();
          double price = (element['price'] as num).toDouble();

          if (storeTotalPrices.containsKey(storeName)) {
            double previousPrice = storeTotalPrices[storeName]!;
            storeTotalPrices[storeName] = previousPrice + (quantity * price);
          } else {
            storeTotalPrices[storeName] = quantity * price;
          }
        });
      }

      storeTotalPrices.forEach((storeName, totalPrice) {
        print('Store: $storeName, Total Price: $totalPrice');
      });

    } catch (e) {
      print('Error ranking stores: $e');
    }
  }

  Future<List<String>> _getMissingProductsIdStores(var idStores) async {
    /// Will use these ids to fetch similar product from our products using some matching criteria.
    final productListNotExistSnapshot = await _fireStore
        .collection('products_clone')
        .where('idStore', whereIn: idStores)
        .where('is_exist', isEqualTo: false)
        .get();

    return productListNotExistSnapshot.docs
        .map((e) => e['idStore'] as String)
        .toList();
  }

  Future<void> rankStoresByPriceTotal(
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
