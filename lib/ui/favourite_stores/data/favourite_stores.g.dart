// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_stores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Stores _$$_StoresFromJson(Map<String, dynamic> json) => _$_Stores(
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      adress: json['adress'] as String,
      zipCodesList: (json['zipCodesList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logo: json['logo'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$_StoresToJson(_$_Stores instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adress': instance.adress,
      'zipCodesList': instance.zipCodesList,
      'logo': instance.logo,
      'isFavorite': instance.isFavorite,
    };
