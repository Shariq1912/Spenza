import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_product_response.freezed.dart';

part 'search_product_response.g.dart';

@freezed
class SearchProductResponse with _$SearchProductResponse {
  const factory SearchProductResponse({
    @JsonKey(name: "department_name") required String departmentName,
    @JsonKey(name: "is_exist") required bool isExist,
    required List<String> genericNames,
    @Default("") String unit,
    @Default("") String site,
    required String measure,
    required double price,
    @JsonKey(name: "product_id") required String productId,
    required String name,
    required String brand,
    required String pImage,
    required double minPrice,
    required double maxPrice,
  }) = _SearchProductResponse;

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchProductResponseFromJson(json);
}
