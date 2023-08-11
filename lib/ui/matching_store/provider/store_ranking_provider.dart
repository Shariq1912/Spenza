import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'package:collection/collection.dart';

part 'store_ranking_provider.g.dart';

@riverpod
class StoreRanking extends _$StoreRanking
    with NearbyStoreMixin, FirestoreAndPrefsMixin {
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

  Future<void> rankStoresByPriceTotal({double radius = 6}) async {
    state = AsyncValue.loading();

    final listId = await prefs.then((prefs) => prefs.getUserListId());

    try {
      // Soriana City Center = 20.68016662, -103.3822084
      final List<Stores> nearbyStores = await getNearbyStores(
        radius: radius,
        firestore: fireStore,
        userLocation: GeoPoint(20.68016662, -103.3822084),
      );

      // Fetch the products in a batched read
      final List<DocumentReference> storeRefs = nearbyStores
          .map((store) =>
              fireStore.collection(StoreConstant.storeCollection).doc(store.id))
          .toList();

      // Fetch all store products that meet the conditions
      final QuerySnapshot storeProductsSnapshot = await fireStore
          .collection('products_mvp')
          .where('is_exist', isEqualTo: true)
          .where('storeRef', whereIn: storeRefs)
          .get();

      // Create a list of Product objects
      final storeProducts = storeProductsSnapshot.docs.map((productSnapshot) {
        final ref = productSnapshot.reference;

        return Product(
          productId: productSnapshot['product_id'].toString(),
          productRef: ref.id.toString(),
          isExist: productSnapshot['is_exist'] as bool,
          department: productSnapshot['department_name'].toString(),
          measure: productSnapshot['measure'].toString(),
          name: productSnapshot['name'].toString(),
          pImage: productSnapshot['pImage'].toString(),
          storeRef: productSnapshot['storeRef'].path.toString(),
          genericNames: List<String>.from(productSnapshot['genericNames']),
          minPrice: productSnapshot['price'].toString(),
          maxPrice: "",
        );
      }).toList();

      final Map<DocumentReference, double> storeTotal = {};
      final Map<DocumentReference, double> matchingProductCounts = {};

      // Fetch the user's product list from the user_product_list subcollection
      QuerySnapshot productListSnapshot = await fireStore
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
      final List<Product> userProducts = await Future.wait(
        productRefs.map(
          (ref) async {
            final productSnapshot = await ref.get();

            return Product(
              productId: productSnapshot['product_id'].toString(),
              productRef: ref.id.toString(),
              isExist: productSnapshot['is_exist'] as bool,
              department: productSnapshot['department_name'].toString(),
              measure: productSnapshot['measure'].toString(),
              name: productSnapshot['name'].toString(),
              pImage: productSnapshot['pImage'].toString(),
              storeRef: productSnapshot['storeRef'].path.toString(),
              genericNames: List<String>.from(productSnapshot['genericNames']),
              minPrice: productSnapshot['price'].toString(),

              /// cast to double while using in the code.
              maxPrice: "",
            );
          },
        ).toList(),
      );

      // print(userProducts.toString());

      for (var storeRef in storeRefs) {
        for (var i = 0; i < productListSnapshot.size; i++) {
          final productSnapshot = productListSnapshot.docs[i];
          final product = userProducts[i];
          final price = double.parse(product.minPrice);
          final quantity = productSnapshot['quantity'];
          final productId = product.productId;

          // print(
          //     "STORE - ${storeRef.path} == Product STORE - ${product.storeRef} == Product - ${product.name} == Price & Qty - $price & $quantity");

          if (product.isExist && product.storeRef == storeRef.path) {
            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 1;

            (productInListMap[storeRef] ??= [])
                .add({'product': product, 'quantity': quantity});

            continue;
          }

          final Product? productInStore = _getSimilarProductFromList(
            storeRef: storeRef.path,
            product: product,
            storeProducts: storeProducts,
            matchingProductCounts: matchingProductCounts,
          );
          if (productInStore == null) {
            // print("MISSING PRODUCT == ${product['name']} - STORE - ${storeRef.id} == Product STORE - ${productStoreRef.id}");

            (missingProductMap[storeRef] ??= [])
                .add({'product': product, 'quantity': quantity});
          } else if (productInStore.productId == productId) {
            final price = double.parse(productInStore.minPrice);

            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 1;

            (productInListMap[storeRef] ??= [])
                .add({'product': productInStore, 'quantity': quantity});
          } else {
            final price = double.parse(productInStore.minPrice);

            /// similar product price

            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 0.9;

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
          totalPrice: totalPrice.toPrecision(2),
          matchingPercentage: matchingPercentage,
        );
        stores.add(store);
      }

      // Sort the stores based on the matching percentage
      stores.sort((a, b) {
        final result = b.matchingPercentage.compareTo(a.matchingPercentage);
        if (result == 0) {
          return a.distance.compareTo(b
              .distance); // Sort by distance when matchingPercentage is the same
        }
        return result;
      });

      state = AsyncValue.data(stores);
    } on NearbyStoreException catch (e) {
      print('Error Nearby stores: $e');
      rankStoresByPriceTotal(
          radius: radius -
              1); // Recursion to avoid radius issues of geo flutter fire plus package.
    } catch (e) {
      //todo Handle in filter exception separately to avoid conflict
      print('Error ranking stores: $e');
      if (radius > 3) {
        rankStoresByPriceTotal(
            radius: radius -
                1); // Recursion to avoid radius issues of geo flutter fire plus package.
      } else
        state =
            AsyncValue.error('Error searching stores: $e', StackTrace.current);
    }
  }

  Product? _getSimilarProductFromList({
    required Product product,
    required List<Product> storeProducts,
    required String storeRef,
    required Map<DocumentReference<Object?>, double> matchingProductCounts,
  }) {
    final productId = product.productId;
    final genericNames = List<String>.from(product.genericNames);
    final measure = product.measure;
    final department = product.department;

    print('Searching for similar product:');
    print('Product ID: $productId');
    print('Generic Names: $genericNames');
    print('Measure: $measure');
    print('Department: $department');

    final exactProduct = storeProducts.firstWhereOrNull(
      (element) =>
          element.storeRef == storeRef &&
          element.productId == productId &&
          element.isExist,
    );

    if (exactProduct != null) {
      print('Found exact product match:');
      print('Product ID: $productId');
      return exactProduct;
    }

    Product? bestMatch;
    double? bestMatchPrice;
    double bestMatchPercentage = 0;

    for (final similarProduct in storeProducts) {
      final similarGenericNames = similarProduct.genericNames;
      final similarMeasure = similarProduct.measure;
      final similarDepartment = similarProduct.department;

      if (similarProduct.storeRef == storeRef &&
          similarMeasure == measure &&
          similarDepartment == department) {
        final similarPrice = double.tryParse(similarProduct.minPrice);
        final double relationPercentage = _calculateRelation(
            genericNames, similarGenericNames.cast<String>());

        if (similarPrice != null &&
            (bestMatch == null ||
                bestMatchPrice == null ||
                relationPercentage > bestMatchPercentage ||
                (relationPercentage == bestMatchPercentage &&
                    similarPrice < bestMatchPrice))) {
          bestMatch = similarProduct;
          bestMatchPrice = similarPrice;
          bestMatchPercentage = relationPercentage;
        }
      }
    }

    if (bestMatchPercentage <= 0.65) {
      print(' similar product Found BUT with ${bestMatchPercentage * 100} %:');
      return null;
    }
    final actualStoreRef = fireStore.doc(storeRef);
    matchingProductCounts[actualStoreRef] =
        (matchingProductCounts[actualStoreRef] ?? 0) + bestMatchPercentage;

    if (bestMatch != null) {
      print('Found similar product:');
      print('Product ID: ${bestMatch.productId}');
      print('Generic Names: ${bestMatch.genericNames}');
      print('Price: ${bestMatch.minPrice}');
    } else {
      print('No similar product found.');
    }

    return bestMatch;
  }

  double _calculateRelation(
      List<String> mainGenericNames, List<String> otherGenericNames) {
    final otherGenericNamesSet = otherGenericNames.toSet();

    final matches = mainGenericNames
        .where((item) => otherGenericNamesSet.contains(item))
        .length;
    final mainLength = mainGenericNames.length;
    final otherLength = otherGenericNames.length;

    final relationPercentage =
        (matches / (mainLength > otherLength ? mainLength : otherLength));

    return relationPercentage.toPrecision(2);
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

    final exactProduct = await fireStore
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

    final similarProducts = await fireStore
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
      storeRef: path,
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

    final userId = await prefs.then((prefs) => prefs.getUserId());

    final rankedData = {
      "similar_products": similarProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData.name,
          "price": double.tryParse(productData.minPrice) ?? 0.0,
          "product_image": productData.pImage,
          "measure": productData.measure,
          "quantity": product['quantity'],
        };
      }).toList(),
      "missing_products": missingProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData.name,
          "price": double.tryParse(productData.minPrice) ?? 0.0,
          "product_image": productData.pImage,
          "measure": productData.measure,
          "quantity": product['quantity'],
        };
      }).toList(),
      "matching_products": productInListProducts.map((product) {
        final productData = product['product'];

        return {
          "name": productData.name,
          "price": double.tryParse(productData.minPrice) ?? 0.0,
          "product_image": productData.pImage,
          "measure": productData.measure,
          "quantity": product['quantity'],
        };
      }).toList(),
      "total": total,
      "store_ref": storeRef,
    };

    print(rankedData.toString());

    try {
      final batch = fireStore.batch();
      batch.set(
        fireStore.collection("ranked_store_products").doc(userId),
        rankedData,
      );
      batch.commit();

      print("Product Saved Successfully!");

      context.pushNamed(RouteManager.selectedStoreScreen);
    } catch (e) {
      print("Error saving product data: $e");
    }
  }
}
