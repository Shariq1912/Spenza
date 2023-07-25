import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_product.freezed.dart';

part 'user_product.g.dart';

@freezed
class UserProduct with _$UserProduct {
  const factory UserProduct({
    required String idStore,
    required String department,
    required String name,
    required String pImage,
    required String measure,
    required String minPrice,
    required String maxPrice,
    @Default(1) int quantity,
  }) = _UserProduct;

  factory UserProduct.fromJson(Map<String, dynamic> json) =>
      _$UserProductFromJson(json);
}
