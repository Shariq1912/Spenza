// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchingStore _$$_MatchingStoreFromJson(Map<String, dynamic> json) =>
    _$_MatchingStore(
      storeRef:
          const DocumentReferenceJsonConverter().fromJson(json['storeRef']),
      logo: json['logo'] as String,
      name: json['name'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      distance: json['distance'] as String,
      address: json['address'] as String,
      matchingPercentage: json['matchingPercentage'] as int,
    );

Map<String, dynamic> _$$_MatchingStoreToJson(_$_MatchingStore instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('storeRef',
      const DocumentReferenceJsonConverter().toJson(instance.storeRef));
  val['logo'] = instance.logo;
  val['name'] = instance.name;
  val['totalPrice'] = instance.totalPrice;
  val['distance'] = instance.distance;
  val['address'] = instance.address;
  val['matchingPercentage'] = instance.matchingPercentage;
  return val;
}
