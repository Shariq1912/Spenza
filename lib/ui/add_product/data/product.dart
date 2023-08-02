import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String productId,
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
    @Default("")
        String maxPrice,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
