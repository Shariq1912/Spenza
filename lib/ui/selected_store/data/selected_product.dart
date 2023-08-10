 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
 import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/utils/document_reference_converter.dart';

 part 'selected_product.freezed.dart';
 part 'selected_product.g.dart';

 @freezed
 class SelectedProduct with _$SelectedProduct {
   @DocumentReferenceJsonConverter()
   const factory SelectedProduct({
     DocumentReference? storeRef,
     @Default(0.0) double total,
     @Default([]) List<SelectedProductList> products,
   }) = _SelectedProduct;



   factory SelectedProduct.fromJson(Map<String, dynamic> json) =>
       _$SelectedProductFromJson(json);
 }