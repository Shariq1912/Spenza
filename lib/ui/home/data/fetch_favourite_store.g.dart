// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_favourite_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FetchFavouriteStores _$$_FetchFavouriteStoresFromJson(
        Map<String, dynamic> json) =>
    _$_FetchFavouriteStores(
      store_ids:
          (json['store_ids'] as List<dynamic>).map((e) => e as String).toList(),
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_FetchFavouriteStoresToJson(
        _$_FetchFavouriteStores instance) =>
    <String, dynamic>{
      'store_ids': instance.store_ids,
      'uid': instance.uid,
    };
