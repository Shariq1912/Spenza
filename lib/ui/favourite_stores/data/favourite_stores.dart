
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_stores.freezed.dart';
part 'favourite_stores.g.dart';

@freezed
class Stores with _$Stores {
  const factory Stores({
    @Default("") String id,
    required String name,
    required String adress,
    required List<String> zipCodesList,
    required String logo,
    @Default(false) bool isFavorite,
  }) = _Stores;

  factory Stores.fromJson(Map<String, dynamic> json) => _$StoresFromJson(json);
}