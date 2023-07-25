// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProduct _$$_UserProductFromJson(Map<String, dynamic> json) =>
    _$_UserProduct(
      idStore: json['idStore'] as String,
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
      'idStore': instance.idStore,
      'department': instance.department,
      'name': instance.name,
      'pImage': instance.pImage,
      'measure': instance.measure,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'quantity': instance.quantity,
    };
