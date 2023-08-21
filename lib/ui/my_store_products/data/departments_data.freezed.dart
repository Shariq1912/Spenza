// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departments_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DepartmentDataClass _$DepartmentDataClassFromJson(Map<String, dynamic> json) {
  return _DepartmentDataClass.fromJson(json);
}

/// @nodoc
mixin _$DepartmentDataClass {
  String get name => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentDataClassCopyWith<DepartmentDataClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentDataClassCopyWith<$Res> {
  factory $DepartmentDataClassCopyWith(
          DepartmentDataClass value, $Res Function(DepartmentDataClass) then) =
      _$DepartmentDataClassCopyWithImpl<$Res, DepartmentDataClass>;
  @useResult
  $Res call({String name, String? documentId});
}

/// @nodoc
class _$DepartmentDataClassCopyWithImpl<$Res, $Val extends DepartmentDataClass>
    implements $DepartmentDataClassCopyWith<$Res> {
  _$DepartmentDataClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? documentId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepartmentDataClassCopyWith<$Res>
    implements $DepartmentDataClassCopyWith<$Res> {
  factory _$$_DepartmentDataClassCopyWith(_$_DepartmentDataClass value,
          $Res Function(_$_DepartmentDataClass) then) =
      __$$_DepartmentDataClassCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? documentId});
}

/// @nodoc
class __$$_DepartmentDataClassCopyWithImpl<$Res>
    extends _$DepartmentDataClassCopyWithImpl<$Res, _$_DepartmentDataClass>
    implements _$$_DepartmentDataClassCopyWith<$Res> {
  __$$_DepartmentDataClassCopyWithImpl(_$_DepartmentDataClass _value,
      $Res Function(_$_DepartmentDataClass) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? documentId = freezed,
  }) {
    return _then(_$_DepartmentDataClass(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DepartmentDataClass implements _DepartmentDataClass {
  const _$_DepartmentDataClass({required this.name, this.documentId});

  factory _$_DepartmentDataClass.fromJson(Map<String, dynamic> json) =>
      _$$_DepartmentDataClassFromJson(json);

  @override
  final String name;
  @override
  final String? documentId;

  @override
  String toString() {
    return 'DepartmentDataClass(name: $name, documentId: $documentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DepartmentDataClass &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, documentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepartmentDataClassCopyWith<_$_DepartmentDataClass> get copyWith =>
      __$$_DepartmentDataClassCopyWithImpl<_$_DepartmentDataClass>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DepartmentDataClassToJson(
      this,
    );
  }
}

abstract class _DepartmentDataClass implements DepartmentDataClass {
  const factory _DepartmentDataClass(
      {required final String name,
      final String? documentId}) = _$_DepartmentDataClass;

  factory _DepartmentDataClass.fromJson(Map<String, dynamic> json) =
      _$_DepartmentDataClass.fromJson;

  @override
  String get name;
  @override
  String? get documentId;
  @override
  @JsonKey(ignore: true)
  _$$_DepartmentDataClassCopyWith<_$_DepartmentDataClass> get copyWith =>
      throw _privateConstructorUsedError;
}
