 import 'package:flutter/foundation.dart';
 import 'package:freezed_annotation/freezed_annotation.dart';

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
 }