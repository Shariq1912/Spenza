import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matching_store.freezed.dart';
part 'matching_store.g.dart';

@freezed
class MatchingStores with _$MatchingStores {
  const factory MatchingStores({
     required String logo,
     required String name,
     required double totalPrice,
     required String distance,
     required String address,
     required int matchingPercentage,
  }) = _MatchingStore;



  factory MatchingStores.fromJson(Map<String, dynamic> json) =>
      _$MatchingStoresFromJson(json);
}