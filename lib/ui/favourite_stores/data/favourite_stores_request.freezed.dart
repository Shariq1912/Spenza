// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_stores_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouriteStoresRequest _$FavouriteStoresRequestFromJson(
    Map<String, dynamic> json) {
  return _FavouriteStoresRequest.fromJson(json);
}

/// @nodoc
mixin _$FavouriteStoresRequest {
  @JsonKey(name: "uid")
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "store_ids")
  List<String> get storeIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouriteStoresRequestCopyWith<FavouriteStoresRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouriteStoresRequestCopyWith<$Res> {
  factory $FavouriteStoresRequestCopyWith(FavouriteStoresRequest value,
          $Res Function(FavouriteStoresRequest) then) =
      _$FavouriteStoresRequestCopyWithImpl<$Res, FavouriteStoresRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "uid") String userId,
      @JsonKey(name: "store_ids") List<String> storeIds});
}

/// @nodoc
class _$FavouriteStoresRequestCopyWithImpl<$Res,
        $Val extends FavouriteStoresRequest>
    implements $FavouriteStoresRequestCopyWith<$Res> {
  _$FavouriteStoresRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? storeIds = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      storeIds: null == storeIds
          ? _value.storeIds
          : storeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavouriteStoresRequestCopyWith<$Res>
    implements $FavouriteStoresRequestCopyWith<$Res> {
  factory _$$_FavouriteStoresRequestCopyWith(_$_FavouriteStoresRequest value,
          $Res Function(_$_FavouriteStoresRequest) then) =
      __$$_FavouriteStoresRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "uid") String userId,
      @JsonKey(name: "store_ids") List<String> storeIds});
}

/// @nodoc
class __$$_FavouriteStoresRequestCopyWithImpl<$Res>
    extends _$FavouriteStoresRequestCopyWithImpl<$Res,
        _$_FavouriteStoresRequest>
    implements _$$_FavouriteStoresRequestCopyWith<$Res> {
  __$$_FavouriteStoresRequestCopyWithImpl(_$_FavouriteStoresRequest _value,
      $Res Function(_$_FavouriteStoresRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? storeIds = null,
  }) {
    return _then(_$_FavouriteStoresRequest(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      storeIds: null == storeIds
          ? _value._storeIds
          : storeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavouriteStoresRequest
    with DiagnosticableTreeMixin
    implements _FavouriteStoresRequest {
  const _$_FavouriteStoresRequest(
      {@JsonKey(name: "uid") required this.userId,
      @JsonKey(name: "store_ids") required final List<String> storeIds})
      : _storeIds = storeIds;

  factory _$_FavouriteStoresRequest.fromJson(Map<String, dynamic> json) =>
      _$$_FavouriteStoresRequestFromJson(json);

  @override
  @JsonKey(name: "uid")
  final String userId;
  final List<String> _storeIds;
  @override
  @JsonKey(name: "store_ids")
  List<String> get storeIds {
    if (_storeIds is EqualUnmodifiableListView) return _storeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_storeIds);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FavouriteStoresRequest(userId: $userId, storeIds: $storeIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FavouriteStoresRequest'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('storeIds', storeIds));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavouriteStoresRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._storeIds, _storeIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, const DeepCollectionEquality().hash(_storeIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavouriteStoresRequestCopyWith<_$_FavouriteStoresRequest> get copyWith =>
      __$$_FavouriteStoresRequestCopyWithImpl<_$_FavouriteStoresRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouriteStoresRequestToJson(
      this,
    );
  }
}

abstract class _FavouriteStoresRequest implements FavouriteStoresRequest {
  const factory _FavouriteStoresRequest(
          {@JsonKey(name: "uid") required final String userId,
          @JsonKey(name: "store_ids") required final List<String> storeIds}) =
      _$_FavouriteStoresRequest;

  factory _FavouriteStoresRequest.fromJson(Map<String, dynamic> json) =
      _$_FavouriteStoresRequest.fromJson;

  @override
  @JsonKey(name: "uid")
  String get userId;
  @override
  @JsonKey(name: "store_ids")
  List<String> get storeIds;
  @override
  @JsonKey(ignore: true)
  _$$_FavouriteStoresRequestCopyWith<_$_FavouriteStoresRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
