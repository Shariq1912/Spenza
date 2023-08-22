// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReceiptModel _$$_ReceiptModelFromJson(Map<String, dynamic> json) =>
    _$_ReceiptModel(
      uid: json['uid'] as String,
      name: json['name'] as String?,
      receipt: json['receipt'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$$_ReceiptModelToJson(_$_ReceiptModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'receipt': instance.receipt,
      'description': instance.description,
      'date': instance.date,
    };
