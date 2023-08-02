import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/my_list_details/data/similar_product_matcher.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'matching_store_provider.g.dart';

@riverpod
class MatchingStore extends _$MatchingStore {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<List<MatchingStores>> build() async {
    return [];
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

          /// Add is_exist field in prices level not product level.
          ///
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
        stores.add(store.copyWith(totalPrice: entry.value.toPrecision(2)));
      }

      stores..sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
      state = AsyncValue.data(stores);
      print('stores are: $stores');
    } catch (e) {
      state =
          AsyncValue.error('Error searching stores: $e', StackTrace.current);
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

        // var newGenericNames = element['genericNames'];    /// Key point to noted,


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
}
