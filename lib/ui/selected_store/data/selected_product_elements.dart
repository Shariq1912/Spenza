 import 'package:flutter/foundation.dart';
 import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/add_product/data/product.dart';

 part 'selected_product_elements.freezed.dart';
 part 'selected_product_elements.g.dart';

 @freezed
 class SelectedProductElement with _$SelectedProductElement {
   const factory SelectedProductElement({
     required String measure,
     required String name,
     @JsonKey(name: "product_image") required String productImage,
     required double price,
     required int quantity,
   }) = _SelectedProductElement;



   factory SelectedProductElement.fromJson(Map<String, dynamic> json) =>
       _$SelectedProductElementFromJson(json);


   factory SelectedProductElement.fromProduct(Product product) {
     return SelectedProductElement(
       measure: product.measure,
       name: product.name,
       productImage: product.pImage,
       price: double.tryParse(product.minPrice) ?? 0.0,
       quantity: product.quantity,
     );
   }
 }