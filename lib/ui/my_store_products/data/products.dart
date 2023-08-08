import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
class ProductModel with _$ProductModel{
  const factory ProductModel({
   required String name,
    required String pImage,
    required String measure,
    required String idStore,
    required String department,
     String? documentId,

}) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}