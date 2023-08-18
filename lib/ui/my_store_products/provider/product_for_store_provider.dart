import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';

part 'product_for_store_provider.g.dart';

@riverpod
class ProductForStore extends _$ProductForStore with FirestoreAndPrefsMixin {
  @override
  FutureOr<List<ProductModel>> build() {
    return [];
  }

  Future<List<ProductModel>> getProductsForStore(String documentId) async {
    try {
      state = AsyncValue.loading();
      DocumentReference storeRef = fireStore
          .collection("stores")
          .doc(documentId); //created the document ref object

      QuerySnapshot<Map<String, dynamic>> productsSnapshot = await fireStore
          .collection('products_mvp')
          .where('storeRef', isEqualTo: storeRef)
          .get();

      final List<ProductModel> pro = productsSnapshot.docs.map((doc) {
        final data = doc.data();
        try{
          final pros = ProductModel.fromJson(data).copyWith(documentId: doc.id);
          return pros;
        }
        catch(e){
          print("Product ID - ${data['product_id']} and Name - ${data['name']} ");
          return ProductModel(name: "name", pImage: "pImage", measure: "measure", productId: "productId", departmentName: "departmentName");
        }
      }).toList();

      pro.forEach((element) {
        print("products : ${element.name}");
      });
      state = AsyncValue.data(pro);
      return pro;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return [];
    }
  }
}
