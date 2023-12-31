import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/add_product/data/search_product_response.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String productId,
    required String productRef,
    required bool isExist,
    required String department,
    // required String departmentRef,
    // required String genericNameRef,
    required String measure,
    required String name,
    required String pImage,

    @Default("") String storeRef,
    @JsonKey(includeFromJson: true, includeToJson: false)
    @Default([])
        List<dynamic> departments,
    @JsonKey(includeFromJson: true, includeToJson: false)
    @Default([])
        List<dynamic> genericNames,
    @JsonKey(includeFromJson: true, includeToJson: false)
    @Default("")
        String minPrice,
    @JsonKey(includeFromJson: true, includeToJson: false)
    @Default("") String maxPrice,

    @Default(0) int quantity,

  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.fromDocument(DocumentSnapshot doc) {
    final Map<String, dynamic> value = doc.data()! as Map<String, dynamic>;

    final List<dynamic> genericNames = value['genericNames'] ?? [];

    return Product(
      productRef: doc.id,
      productId: value['product_id'] ?? '',
      isExist: value['is_exist'] ?? false,
      department: value['department_name'] ?? '',
      departments: [value['department_name']] ?? [],
      measure: value['measure'] == "kg" ? "1 kg" : (value['measure'] ?? ''),
      storeRef: (value['storeRef'] as DocumentReference?)?.id.toString() ?? '',
      name: value['name'] ?? '',
      pImage: value['pImage'] ?? '',
      genericNames: List<String>.from(genericNames),
      minPrice: value['price']?.toString() ?? '0',
      maxPrice:
          "${(value['storeRef'] as DocumentReference?)?.id.toString() ?? ''} - ${genericNames.join(', ')}",
    );
  }

  factory Product.fromSearchResponse(SearchProductResponse response) {
    final List<String> genericNames = response.genericNames;

    return Product(
      productRef: response.productRef,
      productId: response.productId,
      isExist: response.isExist,
      department: response.departmentName,
      departments: [response.departmentName],
      measure: response.measure,
      storeRef: '',
      name: response.name,
      pImage: response.pImage,
      genericNames: genericNames,
      minPrice: response.minPrice.toString(),
      maxPrice: response.maxPrice.toString(),
    );
  }
}
