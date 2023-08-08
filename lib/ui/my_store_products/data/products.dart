import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
class ProductModel with _$Product{
  const factory ProductModel({
   required String name,
    required String pImage,
    required String measure,
    required String idStore,
    required String department,
     String? documentId,

}) = _Product;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}