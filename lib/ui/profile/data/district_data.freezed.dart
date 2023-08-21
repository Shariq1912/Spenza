// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'district_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DistrictData _$DistrictDataFromJson(Map<String, dynamic> json) {
  return _DistrictData.fromJson(json);
}

/// @nodoc
mixin _$DistrictData {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DistrictDataCopyWith<DistrictData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistrictDataCopyWith<$Res> {
  factory $DistrictDataCopyWith(
          DistrictData value, $Res Function(DistrictData) then) =
      _$DistrictDataCopyWithImpl<$Res, DistrictData>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$DistrictDataCopyWithImpl<$Res, $Val extends DistrictData>
    implements $DistrictDataCopyWith<$Res> {
  _$DistrictDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DistrictDataCopyWith<$Res>
    implements $DistrictDataCopyWith<$Res> {
  factory _$$_DistrictDataCopyWith(
          _$_DistrictData value, $Res Function(_$_DistrictData) then) =
      __$$_DistrictDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_DistrictDataCopyWithImpl<$Res>
    extends _$DistrictDataCopyWithImpl<$Res, _$_DistrictData>
    implements _$$_DistrictDataCopyWith<$Res> {
  __$$_DistrictDataCopyWithImpl(
      _$_DistrictData _value, $Res Function(_$_DistrictData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_DistrictData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DistrictData implements _DistrictData {
  const _$_DistrictData({required this.name});

  factory _$_DistrictData.fromJson(Map<String, dynamic> json) =>
      _$$_DistrictDataFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'DistrictData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DistrictData &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DistrictDataCopyWith<_$_DistrictData> get copyWith =>
      __$$_DistrictDataCopyWithImpl<_$_DistrictData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DistrictDataToJson(
      this,
    );
  }
}

abstract class _DistrictData implements DistrictData {
  const factory _DistrictData({required final String name}) = _$_DistrictData;

  factory _DistrictData.fromJson(Map<String, dynamic> json) =
      _$_DistrictData.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_DistrictDataCopyWith<_$_DistrictData> get copyWith =>
      throw _privateConstructorUsedError;
}
