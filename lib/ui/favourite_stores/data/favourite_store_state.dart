import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';

part 'favourite_store_state.freezed.dart';

@freezed
class FavouriteStoreState with _$FavouriteStoreState {
  const factory FavouriteStoreState() = _Initial;
  const factory FavouriteStoreState.loading() = _FavouriteStoreStateLoading;
  const factory FavouriteStoreState.error({required String message}) = _FavouriteStoreStateError;
  const factory FavouriteStoreState.success({required List<Stores> data}) = _FavouriteStoreStateSuccess;
  const factory FavouriteStoreState.redirectUser() = _FavouriteRedirectUser;
}