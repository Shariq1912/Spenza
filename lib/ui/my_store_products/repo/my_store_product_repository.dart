import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/utils/firestore_constants.dart';

import '../data/products.dart';

part 'my_store_product_repository.g.dart';

@riverpod
class MyStoreProductRepository extends _$MyStoreProductRepository  {
  @override
  ApiResponse build() {
    return ApiResponse();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getProductsForStore(String documentId) async {
    state = ApiResponse.loading();
    DocumentReference storeRef = _firestore.doc('/stores/$documentId'); //created the document ref object

    QuerySnapshot<Map<String, dynamic>> productsSnapshot = await _firestore
        .collection('products')
        .where('bstoreRef', isEqualTo: storeRef)
        .get();

    final List<ProductModel> pro = productsSnapshot.docs.map((doc) {
      final data = doc.data();
      final pros = ProductModel.fromJson(data).copyWith(documentId: doc.id);
      return pros;
    }).toList();

    pro.forEach((element) {
      print("products : ${element.name}");
    });
    state = ApiResponse.success(data: pro);
    return pro;
  }





  Future<void> addProductToMyList(String? documentId, String productId, String productRef) async {
    try{
      DocumentReference<Map<String, dynamic>> productReference = await _firestore
        .collection('products')
        .doc(productRef);

    CollectionReference<Map<String, dynamic>> userProductList = await _firestore
        .collection(MyListConstant.myListCollection)
        .doc(documentId)
        .collection(MyListConstant.userProductList);

//    final userProductRequest = userProductData.copyWith(productId: 'products/$productId');
    userProductList.add({
      'product_ref':productReference,
      'product_id':productId,
      'quantity' : 1
    });
   // userProductList.add(userProductRequest.toJson());
    print("productId : $productId");

  }catch(error){print("Error adding product to user's list: $error");
    }
  }

  

}
