import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';

part 'products.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String name,
    required String pImage,
    required String measure,
    @JsonKey(name: "product_id") required String productId, // todo change to productId
    @JsonKey(name: "department_name") required String departmentName,
    String? documentId,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
