// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AllStores _$$_AllStoresFromJson(Map<String, dynamic> json) => _$_AllStores(
      name: json['name'] as String,
      adress: json['adress'] as String,
      zipCodesList: (json['zipCodesList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logo: json['logo'] as String,
      groupName: json['groupName'] as String,
    );

Map<String, dynamic> _$$_AllStoresToJson(_$_AllStores instance) =>
    <String, dynamic>{
      'name': instance.name,
      'adress': instance.adress,
      'zipCodesList': instance.zipCodesList,
      'logo': instance.logo,
      'groupName': instance.groupName,
    };
