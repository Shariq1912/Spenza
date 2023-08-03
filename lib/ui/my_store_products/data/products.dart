import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
class Product with _$Product{
  const factory Product({
   required String name,
    required String pImage,
    required String measure,
    required String idStore,
     String? documentId,

}) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}