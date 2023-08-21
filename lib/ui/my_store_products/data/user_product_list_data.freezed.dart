// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_product_list_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProductData _$UserProductDataFromJson(Map<String, dynamic> json) {
  return _UserProductData.fromJson(json);
}

/// @nodoc
mixin _$UserProductData {
  String get productId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProductDataCopyWith<UserProductData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductDataCopyWith<$Res> {
  factory $UserProductDataCopyWith(
          UserProductData value, $Res Function(UserProductData) then) =
      _$UserProductDataCopyWithImpl<$Res, UserProductData>;
  @useResult
  $Res call({String productId});
}

/// @nodoc
class _$UserProductDataCopyWithImpl<$Res, $Val extends UserProductData>
    implements $UserProductDataCopyWith<$Res> {
  _$UserProductDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserProductDataCopyWith<$Res>
    implements $UserProductDataCopyWith<$Res> {
  factory _$$_UserProductDataCopyWith(
          _$_UserProductData value, $Res Function(_$_UserProductData) then) =
      __$$_UserProductDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$_UserProductDataCopyWithImpl<$Res>
    extends _$UserProductDataCopyWithImpl<$Res, _$_UserProductData>
    implements _$$_UserProductDataCopyWith<$Res> {
  __$$_UserProductDataCopyWithImpl(
      _$_UserProductData _value, $Res Function(_$_UserProductData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$_UserProductData(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserProductData implements _UserProductData {
  const _$_UserProductData({required this.productId});

  factory _$_UserProductData.fromJson(Map<String, dynamic> json) =>
      _$$_UserProductDataFromJson(json);

  @override
  final String productId;

  @override
  String toString() {
    return 'UserProductData(productId: $productId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProductData &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProductDataCopyWith<_$_UserProductData> get copyWith =>
      __$$_UserProductDataCopyWithImpl<_$_UserProductData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProductDataToJson(
      this,
    );
  }
}

abstract class _UserProductData implements UserProductData {
  const factory _UserProductData({required final String productId}) =
      _$_UserProductData;

  factory _UserProductData.fromJson(Map<String, dynamic> json) =
      _$_UserProductData.fromJson;

  @override
  String get productId;
  @override
  @JsonKey(ignore: true)
  _$$_UserProductDataCopyWith<_$_UserProductData> get copyWith =>
      throw _privateConstructorUsedError;
}
