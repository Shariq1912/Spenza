import 'package:cloud_firestore/cloud_firestore.dart';
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
          .map((productSnapshot) => productSnapshot['product_ref'] as DocumentReference)
          .toList();

      // Fetch the products in a batched read
      final List<DocumentSnapshot> productSnapshots = await Future.wait(productRefs.map((ref) => ref.get()));

      for (final Stores store in nearbyStores) {
        final DocumentReference storeRef = _firestore
            .collection(StoreConstant.storeCollection)
            .doc(store.id);

        for (var i = 0; i < productListSnapshot.size; i++) {
          final productSnapshot = productListSnapshot.docs[i];
          // final productRef = productRef[i];
          final product = productSnapshots[i];

          final isProductExist = product['is_exist'];
          final quantity = productSnapshot['quantity'];
          final price = (product['price'] as num).toDouble();
          if (isProductExist) {
            print(
                "STORE - ${storeRef.id} == Product - ${product['name']} == Price & Qty - $price & $quantity");
            storeTotal[storeRef] =
                (storeTotal[storeRef] ?? 0) + (quantity * price);

            matchingProductCounts[storeRef] =
                (matchingProductCounts[storeRef] ?? 0) + 1;
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

        print(
            'Store: ${storeRef.id}, Total Price: ${totalPrice.toPrecision(2)}, Matching Percentage: ${matchingPercentage.toStringAsFixed(2)}%');

        final store = await _getStoreFromPath(
            path: storeRef,
            totalPrice: totalPrice,
            matchingPercentage: matchingPercentage);
        stores.add(store);
      }

      print('Stores List: ${stores.toString()}');

      state = AsyncValue.data(stores);
    } catch (e) {
      print('Error ranking stores: $e');
      state =
          AsyncValue.error('Error searching stores: $e', StackTrace.current);
    }
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
}
