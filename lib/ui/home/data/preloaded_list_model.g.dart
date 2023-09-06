// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preloaded_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PreloadedListModel _$$_PreloadedListModelFromJson(
        Map<String, dynamic> json) =>
    _$_PreloadedListModel(
      id: json['id'] as String,
      name: json['name'] as String,
      preloadedPhoto: json['preloaded_photo'] as String,
      description: json['description'] as String,
      path: json['path'] as String,
      receiptCount: json['receiptCount'] as String?,
      count: json['count'] as String?,
    );

Map<String, dynamic> _$$_PreloadedListModelToJson(
        _$_PreloadedListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preloaded_photo': instance.preloadedPhoto,
      'description': instance.description,
      'path': instance.path,
      'receiptCount': instance.receiptCount,
      'count': instance.count,
    };
