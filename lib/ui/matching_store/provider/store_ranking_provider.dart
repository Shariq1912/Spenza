import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/my_list_details/data/similar_product_matcher.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'store_ranking_provider.g.dart';

@riverpod
class StoreRanking extends _$StoreRanking with NearbyStoreMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<DocumentReference, List<Map<String, dynamic>>> missingProductMap =
      {};
  final Map<DocumentReference, List<Map<String, dynamic>>> similarProductMap =
      {};
  final Map<DocumentReference, List<Map<String, dynamic>>> productInListMap =
      {};

  @override
  Future<List<MatchingStores>> build() async {
    return [];
  }

  Future<void> rankStoresByPriceTotal(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    state = AsyncValue.loading();

    try {
      // Soriana City Center = 20.68016662, -103.3822084
      final nearbyStores = await getNearbyStores(
        firestore: _firestore,
        userLocation: GeoPoint(20.68016662, -103.3822084),
      );

      final Map<DocumentReference, double> storeTotal = {};
      final Map<DocumentReference, int> matchingProductCounts = {};

      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await _firestore
          .collection('mylist')
          .doc(listId)
          .collection('user_product_list')
          .get();

      // Build a list of product references to fetch in a batched read
      final List<DocumentReference> productRefs = productListSnapshot.docs
          .map((productSnapshot) =>
              productSnapshot['product_ref'] as DocumentReference)
          .toList();

      // Fetch the products in a batched read
      final List<DocumentSnapshot> productSnapshots =
          await Future.wait(productRefs.map((ref) => ref.get()));

      for (final Stores store in nearbyStores) {
        final DocumentReference storeRef =
            _firestore.collection(StoreConstant.storeCollection).doc(store.id);

        for (var i = 0; i < productListSnapshot.size; i++) {
          final productSnapshot = productListSnapshot.docs[i];
          // final productRef = productRef[i];
          final DocumentSnapshot<Object?> product = productSnapshots[i];

          final isProductExist = product['is_exist'];
          final quantity = productSnapshot['quantity'];
          final price = (product['price'] as num).toDouble();
          final productStoreRef = product['storeRef'];
          final productId = product['product_id'];

          // print(
          //     "STORE - ${storeRef.id} == Product STORE - ${productStoreRef.id} == Product - ${product['name']} == Price & Qty - $price & $quantity");

          if (isProductExist && productStoreRef.id == storeRef.id) {
            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 1;

            (productInListMap[storeRef] ??= [])
                .add({'product': product, 'quantity': quantity});

            continue;
          }

          final QueryDocumentSnapshot<Map<String, dynamic>>? productInStore =
              await _getSimilarProduct(
            product: product,
            storeRef: storeRef,
            isExist: isProductExist,
          );

          if (productInStore == null) {
            // print("MISSING PRODUCT == ${product['name']} - STORE - ${storeRef.id} == Product STORE - ${productStoreRef.id}");

            (missingProductMap[storeRef] ??= [])
                .add({'product': product, 'quantity': quantity});
          } else if (productInStore['product_id'] == productId) {
            final price = (productInStore['price'] as num).toDouble();

            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 1;

            (productInListMap[storeRef] ??= [])
                .add({'product': product, 'quantity': quantity});
          } else {
            final price = (productInStore['price'] as num).toDouble();

            /// similar product price

            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            (similarProductMap[storeRef] ??= [])
                .add({'product': productInStore, 'quantity': quantity});
          }
        }
      }

      final List<MatchingStores> stores = [];
      for (MapEntry<DocumentReference<Object?>, double> entry
          in storeTotal.entries) {
        final storeRef = entry.key;
        final totalPrice = entry.value;

        final matchingProductCount = matchingProductCounts[storeRef] ?? 0;

        // Calculate matching product percentage
        final matchingPercentage =
            (matchingProductCount / productListSnapshot.size) * 100;

        // print(
        //     'Store: ${storeRef.id}, Total Price: ${totalPrice.toPrecision(2)}, Matching Percentage: ${matchingPercentage.toStringAsFixed(2)}%');

        final store = await _getStoreFromPath(
            path: storeRef,
            totalPrice: totalPrice,
            matchingPercentage: matchingPercentage);
        stores.add(store.copyWith(storeRef: storeRef));
      }

      // print('Stores List: ${stores.toString()}');

      state = AsyncValue.data(stores);
    } catch (e) {
      print('Error ranking stores: $e');
      state =
          AsyncValue.error('Error searching stores: $e', StackTrace.current);
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _getSimilarProduct({
    required DocumentSnapshot<Object?> product,
    required DocumentReference storeRef,
    required bool isExist,
  }) async {
    final productId = product['product_id'];
    final genericNames = List<String>.from(product['genericNames']);
    final measure = product['measure'];
    final department = product['department_name'];

    // print('Searching for similar product:');
    // print('Product ID: $productId');
    // print('Generic Names: $genericNames');
    // print('Measure: $measure');
    // print('Department: $department');

    final exactProduct = await _firestore
        .collection('products_mvp')
        .where('is_exist', isEqualTo: true)
        .where('storeRef', isEqualTo: storeRef)
        .where('product_id', isEqualTo: productId)
        .limit(1)
        .get();

    if (exactProduct.docs.isNotEmpty) {
      // print('Found exact product match:');
      // print('Product ID: $productId');
      return exactProduct.docs.first;
    }

    final similarProducts = await _firestore
        .collection('products_mvp')
        .where('is_exist', isEqualTo: true)
        .where('storeRef', isEqualTo: storeRef)
        .where('measure', isEqualTo: measure)
        .where('department_name', isEqualTo: department)
        .get();

    QueryDocumentSnapshot<Map<String, dynamic>>? bestMatch;

    for (final similarProduct in similarProducts.docs) {
      final productGenericNames =
          List<String>.from(similarProduct['genericNames']);

      if (productGenericNames.every((name) => genericNames.contains(name))) {
        if (bestMatch == null || similarProduct['price'] < bestMatch['price']) {
          bestMatch = similarProduct;
        }
      }
    }

    /*if (bestMatch != null) {
      print('Found similar product:');
      print('Product ID: ${bestMatch['product_id']}');
      print('Generic Names: ${bestMatch['genericNames']}');
      print('Price: ${bestMatch['price']}');
    } else {
      print('No similar product found.');
    }*/

    return bestMatch;
  }

  Future<MatchingStores> _getStoreFromPath(
      {required DocumentReference path,
      required double totalPrice,
      required double matchingPercentage}) async {
    final storeSnapshot = await path.get();

    final location = storeSnapshot['location'] as GeoPoint;

    final distance = await getDistanceFromLocation(
        userLocation: GeoPoint(20.68016662, -103.3822084),
        destinationLocation: location);

    return MatchingStores(
      logo: storeSnapshot['logo'],
      name: storeSnapshot['name'],
      totalPrice: totalPrice,
      matchingPercentage: matchingPercentage.toInt(),
      distance: distance.formatDistance(),
      address: storeSnapshot[
          'adress'], //todo change the typo address once field changed in db
    );
  }

  Future<void> redirectUserToStoreDetails({
    required DocumentReference storeRef,
    required BuildContext context,
    required var total,
  }) async {
    print("STORE REF = ${storeRef.id}");

    final similarProducts = similarProductMap[storeRef] ?? [];
    final missingProducts = missingProductMap[storeRef] ?? [];
    final productInListProducts = productInListMap[storeRef] ?? [];

    print("In List Product = ${productInListProducts.toString()}");

    final userId = "Cool User";
    final rankedData = {
      "similar_products": similarProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData['name'],
          "price": productData['price'],
          "product_image": productData['pImage'],
          "measure": productData['measure'],
          "quantity": product['quantity'],
        };
      }).toList(),
      "missing_products": missingProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData['name'],
          "price": productData['price'],
          "product_image": productData['pImage'],
          "measure": productData['measure'],
          "quantity": product['quantity'],
        };
      }).toList(),
      "matching_products": productInListProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData['name'],
          "price": productData['price'],
          "product_image": productData['pImage'],
          "measure": productData['measure'],
          "quantity": product['quantity'],
        };
      }).toList(),
      "total": total,
      "store_ref": storeRef,
    };

    print(rankedData.toString());

    try {
      await _firestore
          .collection("ranked_store_products")
          .doc(userId)
          .set(rankedData);

      print("Product Saved Successfully!");
    } catch (e) {
      print("Error saving product data: $e");
    }
  }
}
