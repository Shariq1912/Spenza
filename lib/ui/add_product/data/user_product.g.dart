// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProduct _$$_UserProductFromJson(Map<String, dynamic> json) =>
    _$_UserProduct(
      productId: json['productId'] as String,
      department: json['department'] as String,
      name: json['name'] as String,
      pImage: json['pImage'] as String,
      measure: json['measure'] as String,
      minPrice: json['minPrice'] as String,
      maxPrice: json['maxPrice'] as String,
      quantity: json['quantity'] as int? ?? 1,
    );

Map<String, dynamic> _$$_UserProductToJson(_$_UserProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'department': instance.department,
      'name': instance.name,
      'pImage': instance.pImage,
      'measure': instance.measure,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'quantity': instance.quantity,
    };
