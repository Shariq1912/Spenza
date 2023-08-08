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
      idStore: json['idStore'] as String,
      department: json['department'] as String,
      documentId: json['documentId'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pImage': instance.pImage,
      'measure': instance.measure,
      'idStore': instance.idStore,
      'department': instance.department,
      'documentId': instance.documentId,
    };
