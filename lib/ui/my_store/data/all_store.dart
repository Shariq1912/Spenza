import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_store.freezed.dart';
part 'all_store.g.dart';

@freezed
class AllStores with _$AllStores {
  const factory AllStores(
      {required String name,
      required String adress,
      required List<String> zipCodesList,
      required String logo,
        @Default(false) bool isFavorite,
        String? documentId,
      required String groupName}) = _AllStores;


  factory AllStores.fromJson(Map<String, dynamic> json) =>
      _$_AllStores.fromJson(json);
}
