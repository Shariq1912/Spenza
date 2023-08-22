// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) {
  return _ReceiptModel.fromJson(json);
}

/// @nodoc
mixin _$ReceiptModel {
  String get uid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get receipt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiptModelCopyWith<ReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptModelCopyWith<$Res> {
  factory $ReceiptModelCopyWith(
          ReceiptModel value, $Res Function(ReceiptModel) then) =
      _$ReceiptModelCopyWithImpl<$Res, ReceiptModel>;
  @useResult
  $Res call(
      {String uid,
      String? name,
      String? receipt,
      String? description,
      String? date});
}

/// @nodoc
class _$ReceiptModelCopyWithImpl<$Res, $Val extends ReceiptModel>
    implements $ReceiptModelCopyWith<$Res> {
  _$ReceiptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = freezed,
    Object? receipt = freezed,
    Object? description = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceiptModelCopyWith<$Res>
    implements $ReceiptModelCopyWith<$Res> {
  factory _$$_ReceiptModelCopyWith(
          _$_ReceiptModel value, $Res Function(_$_ReceiptModel) then) =
      __$$_ReceiptModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? name,
      String? receipt,
      String? description,
      String? date});
}

/// @nodoc
class __$$_ReceiptModelCopyWithImpl<$Res>
    extends _$ReceiptModelCopyWithImpl<$Res, _$_ReceiptModel>
    implements _$$_ReceiptModelCopyWith<$Res> {
  __$$_ReceiptModelCopyWithImpl(
      _$_ReceiptModel _value, $Res Function(_$_ReceiptModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = freezed,
    Object? receipt = freezed,
    Object? description = freezed,
    Object? date = freezed,
  }) {
    return _then(_$_ReceiptModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _value.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReceiptModel implements _ReceiptModel {
  const _$_ReceiptModel(
      {required this.uid,
      this.name,
      this.receipt,
      this.description,
      this.date});

  factory _$_ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReceiptModelFromJson(json);

  @override
  final String uid;
  @override
  final String? name;
  @override
  final String? receipt;
  @override
  final String? description;
  @override
  final String? date;

  @override
  String toString() {
    return 'ReceiptModel(uid: $uid, name: $name, receipt: $receipt, description: $description, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceiptModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, name, receipt, description, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceiptModelCopyWith<_$_ReceiptModel> get copyWith =>
      __$$_ReceiptModelCopyWithImpl<_$_ReceiptModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceiptModelToJson(
      this,
    );
  }
}

abstract class _ReceiptModel implements ReceiptModel {
  const factory _ReceiptModel(
      {required final String uid,
      final String? name,
      final String? receipt,
      final String? description,
      final String? date}) = _$_ReceiptModel;

  factory _ReceiptModel.fromJson(Map<String, dynamic> json) =
      _$_ReceiptModel.fromJson;

  @override
  String get uid;
  @override
  String? get name;
  @override
  String? get receipt;
  @override
  String? get description;
  @override
  String? get date;
  @override
  @JsonKey(ignore: true)
  _$$_ReceiptModelCopyWith<_$_ReceiptModel> get copyWith =>
      throw _privateConstructorUsedError;
}
