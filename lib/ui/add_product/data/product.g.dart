// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['productId'] as String,
      productRef: json['productRef'] as String,
      isExist: json['isExist'] as bool,
      department: json['department'] as String,
      measure: json['measure'] as String,
      name: json['name'] as String,
      pImage: json['pImage'] as String,
      storeRef: json['storeRef'] as String? ?? "",
      departments: json['departments'] as List<dynamic>? ?? const [],
      genericNames: json['genericNames'] as List<dynamic>? ?? const [],
      minPrice: json['minPrice'] as String? ?? "",
      maxPrice: json['maxPrice'] as String? ?? "",
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productRef': instance.productRef,
      'isExist': instance.isExist,
      'department': instance.department,
      'measure': instance.measure,
      'name': instance.name,
      'pImage': instance.pImage,
      'storeRef': instance.storeRef,
    };
