import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';

part 'selected_product_list.freezed.dart';
part 'selected_product_list.g.dart';


@freezed
class SelectedProductList with _$SelectedProductList {
  const factory SelectedProductList.similarProduct({required SelectedProductElement product}) = SimilarProduct;
  const factory SelectedProductList.missingProduct({required SelectedProductElement product}) = MissingProduct;
  const factory SelectedProductList.exactProduct({required SelectedProductElement product}) = ExactProduct;
  const factory SelectedProductList.label({required String label}) = Label;


  factory SelectedProductList.fromJson(Map<String, dynamic> json) =>
      _$SelectedProductListFromJson(json);
}