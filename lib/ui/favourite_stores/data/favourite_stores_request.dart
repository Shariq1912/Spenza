import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_stores_request.freezed.dart';
part 'favourite_stores_request.g.dart';

@freezed
class FavouriteStoresRequest with _$FavouriteStoresRequest {
  const factory FavouriteStoresRequest({
    @JsonKey(name: "uid") required String userId,
    @JsonKey(name: "store_ids") required List<String> storeIds,
  }) = _FavouriteStoresRequest;

  factory FavouriteStoresRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteStoresRequestFromJson(json);
}
