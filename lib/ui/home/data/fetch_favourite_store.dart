import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_favourite_store.freezed.dart';
part 'fetch_favourite_store.g.dart';

@freezed
class FetchFavouriteStores with _$FetchFavouriteStores{
  const factory FetchFavouriteStores({
    required List<String> store_ids,
    required String uid

}) = _FetchFavouriteStores;
factory FetchFavouriteStores.fromJson(Map<String, dynamic> json) => _$FetchFavouriteStoresFromJson(json);
}