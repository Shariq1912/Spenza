// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_product_insert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProductInsert _$UserProductInsertFromJson(Map<String, dynamic> json) {
  return _UserProductInsert.fromJson(json);
}

/// @nodoc
mixin _$UserProductInsert {
  DocumentReference<Object?>? get productRef =>
      throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProductInsertCopyWith<UserProductInsert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductInsertCopyWith<$Res> {
  factory $UserProductInsertCopyWith(
          UserProductInsert value, $Res Function(UserProductInsert) then) =
      _$UserProductInsertCopyWithImpl<$Res, UserProductInsert>;
  @useResult
  $Res call(
      {DocumentReference<Object?>? productRef, String productId, int quantity});
}

/// @nodoc
class _$UserProductInsertCopyWithImpl<$Res, $Val extends UserProductInsert>
    implements $UserProductInsertCopyWith<$Res> {
  _$UserProductInsertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productRef = freezed,
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      productRef: freezed == productRef
          ? _value.productRef
          : productRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserProductInsertCopyWith<$Res>
    implements $UserProductInsertCopyWith<$Res> {
  factory _$$_UserProductInsertCopyWith(_$_UserProductInsert value,
          $Res Function(_$_UserProductInsert) then) =
      __$$_UserProductInsertCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DocumentReference<Object?>? productRef, String productId, int quantity});
}

/// @nodoc
class __$$_UserProductInsertCopyWithImpl<$Res>
    extends _$UserProductInsertCopyWithImpl<$Res, _$_UserProductInsert>
    implements _$$_UserProductInsertCopyWith<$Res> {
  __$$_UserProductInsertCopyWithImpl(
      _$_UserProductInsert _value, $Res Function(_$_UserProductInsert) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productRef = freezed,
    Object? productId = null,
    Object? quantity = null,
  }) {
    return _then(_$_UserProductInsert(
      productRef: freezed == productRef
          ? _value.productRef
          : productRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@DocumentReferenceJsonConverter()
@JsonSerializable(
    explicitToJson: true, fieldRename: FieldRename.snake, includeIfNull: false)
class _$_UserProductInsert
    with DiagnosticableTreeMixin
    implements _UserProductInsert {
  const _$_UserProductInsert(
      {this.productRef, required this.productId, this.quantity = 1});

  factory _$_UserProductInsert.fromJson(Map<String, dynamic> json) =>
      _$$_UserProductInsertFromJson(json);

  @override
  final DocumentReference<Object?>? productRef;
  @override
  final String productId;
  @override
  @JsonKey()
  final int quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProductInsert(productRef: $productRef, productId: $productId, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserProductInsert'))
      ..add(DiagnosticsProperty('productRef', productRef))
      ..add(DiagnosticsProperty('productId', productId))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProductInsert &&
            (identical(other.productRef, productRef) ||
                other.productRef == productRef) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productRef, productId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProductInsertCopyWith<_$_UserProductInsert> get copyWith =>
      __$$_UserProductInsertCopyWithImpl<_$_UserProductInsert>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProductInsertToJson(
      this,
    );
  }
}

abstract class _UserProductInsert implements UserProductInsert {
  const factory _UserProductInsert(
      {final DocumentReference<Object?>? productRef,
      required final String productId,
      final int quantity}) = _$_UserProductInsert;

  factory _UserProductInsert.fromJson(Map<String, dynamic> json) =
      _$_UserProductInsert.fromJson;

  @override
  DocumentReference<Object?>? get productRef;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_UserProductInsertCopyWith<_$_UserProductInsert> get copyWith =>
      throw _privateConstructorUsedError;
}
