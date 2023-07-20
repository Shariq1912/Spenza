import 'package:freezed_annotation/freezed_annotation.dart';

import '../../favourite_stores/data/favourite_stores.dart';
import 'fetch_favourite_store.dart';

part 'fetch_favourite_store_state.freezed.dart';

@freezed
class FetchFavouriteStoreState with _$FetchFavouriteStoreState {
  const factory FetchFavouriteStoreState() = _Initial;
  const factory FetchFavouriteStoreState.loading() = _FetchFavouriteStoreStateLoading;
  const factory FetchFavouriteStoreState.error({required String message}) = _FetchFavouriteStoreStateError;
  const factory FetchFavouriteStoreState.success({required List<FetchFavouriteStores> data}) = _FetchFavouriteStoreStateSuccess;
  const factory FetchFavouriteStoreState.redirectUser() = _FetchFavouriteStoreStateeRedirectUser;
}