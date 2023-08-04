import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/utils/document_reference_converter.dart';

part 'matching_store.freezed.dart';
part 'matching_store.g.dart';

@freezed
class MatchingStores with _$MatchingStores {
  @DocumentReferenceJsonConverter()
  @JsonSerializable(
    explicitToJson: true,
    includeIfNull: false,
  )
  const factory MatchingStores({
    DocumentReference? storeRef,
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