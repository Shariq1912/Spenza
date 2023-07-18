// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_stores_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavouriteStoresRequest _$$_FavouriteStoresRequestFromJson(
        Map<String, dynamic> json) =>
    _$_FavouriteStoresRequest(
      userId: json['uid'] as String,
      storeIds:
          (json['store_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_FavouriteStoresRequestToJson(
        _$_FavouriteStoresRequest instance) =>
    <String, dynamic>{
      'uid': instance.userId,
      'store_ids': instance.storeIds,
    };
