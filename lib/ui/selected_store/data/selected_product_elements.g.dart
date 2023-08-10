// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_product_elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SelectedProductElement _$$_SelectedProductElementFromJson(
        Map<String, dynamic> json) =>
    _$_SelectedProductElement(
      measure: json['measure'] as String,
      name: json['name'] as String,
      productImage: json['product_image'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$$_SelectedProductElementToJson(
        _$_SelectedProductElement instance) =>
    <String, dynamic>{
      'measure': instance.measure,
      'name': instance.name,
      'product_image': instance.productImage,
      'price': instance.price,
      'quantity': instance.quantity,
    };
