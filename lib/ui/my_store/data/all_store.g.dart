// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AllStores _$$_AllStoresFromJson(Map<String, dynamic> json) => _$_AllStores(
      name: json['name'] as String,
      address: json['address'] as String,
      zipCodesList: (json['zipCodesList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logo: json['logo'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      documentId: json['documentId'] as String?,
      groupName: json['groupName'] as String,
    );

Map<String, dynamic> _$$_AllStoresToJson(_$_AllStores instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'zipCodesList': instance.zipCodesList,
      'logo': instance.logo,
      'isFavorite': instance.isFavorite,
      'documentId': instance.documentId,
      'groupName': instance.groupName,
    };
