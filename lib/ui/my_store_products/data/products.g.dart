// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      name: json['name'] as String,
      pImage: json['pImage'] as String,
      measure: json['measure'] as String,
      productId: json['product_id'] as String,
      departmentName: json['department_name'] as String,
      documentId: json['documentId'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pImage': instance.pImage,
      'measure': instance.measure,
      'product_id': instance.productId,
      'department_name': instance.departmentName,
      'documentId': instance.documentId,
    };
