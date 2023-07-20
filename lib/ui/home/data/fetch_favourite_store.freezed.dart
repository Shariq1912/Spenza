// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_favourite_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FetchFavouriteStores _$FetchFavouriteStoresFromJson(Map<String, dynamic> json) {
  return _FetchFavouriteStores.fromJson(json);
}

/// @nodoc
mixin _$FetchFavouriteStores {
  List<String> get store_ids => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FetchFavouriteStoresCopyWith<FetchFavouriteStores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchFavouriteStoresCopyWith<$Res> {
  factory $FetchFavouriteStoresCopyWith(FetchFavouriteStores value,
          $Res Function(FetchFavouriteStores) then) =
      _$FetchFavouriteStoresCopyWithImpl<$Res, FetchFavouriteStores>;
  @useResult
  $Res call({List<String> store_ids, String uid});
}

/// @nodoc
class _$FetchFavouriteStoresCopyWithImpl<$Res,
        $Val extends FetchFavouriteStores>
    implements $FetchFavouriteStoresCopyWith<$Res> {
  _$FetchFavouriteStoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? store_ids = null,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      store_ids: null == store_ids
          ? _value.store_ids
          : store_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FetchFavouriteStoresCopyWith<$Res>
    implements $FetchFavouriteStoresCopyWith<$Res> {
  factory _$$_FetchFavouriteStoresCopyWith(_$_FetchFavouriteStores value,
          $Res Function(_$_FetchFavouriteStores) then) =
      __$$_FetchFavouriteStoresCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> store_ids, String uid});
}

/// @nodoc
class __$$_FetchFavouriteStoresCopyWithImpl<$Res>
    extends _$FetchFavouriteStoresCopyWithImpl<$Res, _$_FetchFavouriteStores>
    implements _$$_FetchFavouriteStoresCopyWith<$Res> {
  __$$_FetchFavouriteStoresCopyWithImpl(_$_FetchFavouriteStores _value,
      $Res Function(_$_FetchFavouriteStores) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? store_ids = null,
    Object? uid = null,
  }) {
    return _then(_$_FetchFavouriteStores(
      store_ids: null == store_ids
          ? _value._store_ids
          : store_ids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FetchFavouriteStores implements _FetchFavouriteStores {
  const _$_FetchFavouriteStores(
      {required final List<String> store_ids, required this.uid})
      : _store_ids = store_ids;

  factory _$_FetchFavouriteStores.fromJson(Map<String, dynamic> json) =>
      _$$_FetchFavouriteStoresFromJson(json);

  final List<String> _store_ids;
  @override
  List<String> get store_ids {
    if (_store_ids is EqualUnmodifiableListView) return _store_ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_store_ids);
  }

  @override
  final String uid;

  @override
  String toString() {
    return 'FetchFavouriteStores(store_ids: $store_ids, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FetchFavouriteStores &&
            const DeepCollectionEquality()
                .equals(other._store_ids, _store_ids) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_store_ids), uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FetchFavouriteStoresCopyWith<_$_FetchFavouriteStores> get copyWith =>
      __$$_FetchFavouriteStoresCopyWithImpl<_$_FetchFavouriteStores>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FetchFavouriteStoresToJson(
      this,
    );
  }
}

abstract class _FetchFavouriteStores implements FetchFavouriteStores {
  const factory _FetchFavouriteStores(
      {required final List<String> store_ids,
      required final String uid}) = _$_FetchFavouriteStores;

  factory _FetchFavouriteStores.fromJson(Map<String, dynamic> json) =
      _$_FetchFavouriteStores.fromJson;

  @override
  List<String> get store_ids;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_FetchFavouriteStoresCopyWith<_$_FetchFavouriteStores> get copyWith =>
      throw _privateConstructorUsedError;
}
