import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/selected_store/data/selected_product.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'selected_store_provider.g.dart';

@riverpod
class SelectedStore extends _$SelectedStore with FirestoreAndPrefsMixin {

  @override
  Future<SelectedProduct> build() async {
    return SelectedProduct();
  }

  Future<void> getSelectedStoreProducts() async {
    state = AsyncValue.loading();
    final userId = await prefs.then((prefs) => prefs.getUserId());

    final DocumentSnapshot<Map<String, dynamic>> query =
        await fireStore.collection('ranked_store_products').doc(userId).get();

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
