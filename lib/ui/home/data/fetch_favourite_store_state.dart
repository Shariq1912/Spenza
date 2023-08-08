import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';

part 'fetch_favourite_store_state.freezed.dart';

@freezed
class FetchFavouriteStoreState with _$FetchFavouriteStoreState {
  const factory FetchFavouriteStoreState() = _Initial;
  const factory FetchFavouriteStoreState.loading() = _FetchFavouriteStoreStateLoading;
  const factory FetchFavouriteStoreState.error({required String message}) = _FetchFavouriteStoreStateError;
  const factory FetchFavouriteStoreState.success({required List<AllStores> data}) = _FetchFavouriteStoreStateSuccess;
  const factory FetchFavouriteStoreState.redirectUser() = _FetchFavouriteStoreStateeRedirectUser;
  const factory FetchFavouriteStoreState.empty({required String message}) = _FetchFavouriteStoreStateEmpty;
}