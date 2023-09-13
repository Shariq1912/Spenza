// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_stores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Stores _$$_StoresFromJson(Map<String, dynamic> json) => _$_Stores(
      id: json['id'] as String? ?? "",
      groupName: json['groupName'] as String? ?? "",
      name: json['name'] as String,
      address: json['address'] as String,
      zipCodesList: (json['zipCodesList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logo: json['logo'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$_StoresToJson(_$_Stores instance) => <String, dynamic>{
      'id': instance.id,
      'groupName': instance.groupName,
      'name': instance.name,
      'address': instance.address,
      'zipCodesList': instance.zipCodesList,
      'logo': instance.logo,
      'isFavorite': instance.isFavorite,
    };
