// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchingStore _$$_MatchingStoreFromJson(Map<String, dynamic> json) =>
    _$_MatchingStore(
      logo: json['logo'] as String,
      name: json['name'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$_MatchingStoreToJson(_$_MatchingStore instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'name': instance.name,
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'address': instance.address,
    };
