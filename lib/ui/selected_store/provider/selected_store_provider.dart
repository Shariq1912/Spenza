import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/nearby_store_helper.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/selected_store/data/selected_product.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'package:collection/collection.dart';

part 'selected_store_provider.g.dart';

@riverpod
class SelectedStore extends _$SelectedStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<SelectedProduct> build() async {
    return SelectedProduct();
  }

  Future<void> getSelectedStoreProducts(
      {String listId = "4NlYnhmchdlu528Gw2yK"}) async {
    state = AsyncValue.loading();

    final userId = "Cool User";
    final List<SelectedProductList> list = [];
    final DocumentSnapshot<Map<String, dynamic>> query =
        await _firestore.collection('ranked_store_products').doc(userId).get();

    final total = query['total'] ?? 0.0;
    final storeRef = query['store_ref'];
    final List<dynamic> matchingProductsData = query['matching_products'];
    final List<dynamic> missingProductsData = query['missing_products'];
    final List<dynamic> similarProductsData = query['similar_products'];

    final List<SelectedProductList> matchingProducts = matchingProductsData
        .map((productData) => SelectedProductList.exactProduct(
              product: SelectedProductElement.fromJson(productData),
            ))
        .toList();

    final List<SelectedProductList> missingProducts = missingProductsData
        .map((productData) => SelectedProductList.missingProduct(
              product: SelectedProductElement.fromJson(productData),
            ))
        .toList();

    final List<SelectedProductList> similarProducts = similarProductsData
        .map((productData) => SelectedProductList.similarProduct(
              product: SelectedProductElement.fromJson(productData),
            ))
        .toList();

    final labeledProducts = [
      matchingProducts.isNotEmpty
          ? SelectedProductList.label(label: "Matching Products")
          : SelectedProductList.label(label: ""),
      ...matchingProducts,
      similarProducts.isNotEmpty
          ? SelectedProductList.label(label: "Similar Products")
          : SelectedProductList.label(label: ""),
      ...similarProducts,
      missingProducts.isNotEmpty
          ? SelectedProductList.label(label: "Missing Products")
          : SelectedProductList.label(label: ""),
      ...missingProducts,
    ];

    final selectedProduct = SelectedProduct(
      storeRef: storeRef,
      total: total,
      products: labeledProducts,
    );

    print(selectedProduct.toString());

    state = AsyncValue.data(selectedProduct);
  }
}
