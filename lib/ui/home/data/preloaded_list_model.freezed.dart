// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preloaded_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PreloadedListModel _$PreloadedListModelFromJson(Map<String, dynamic> json) {
  return _PreloadedListModel.fromJson(json);
}

/// @nodoc
mixin _$PreloadedListModel {
  String get name => throw _privateConstructorUsedError;
  String get preloaded_photo => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreloadedListModelCopyWith<PreloadedListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreloadedListModelCopyWith<$Res> {
  factory $PreloadedListModelCopyWith(
          PreloadedListModel value, $Res Function(PreloadedListModel) then) =
      _$PreloadedListModelCopyWithImpl<$Res, PreloadedListModel>;
  @useResult
  $Res call({String name, String preloaded_photo, String description});
}

/// @nodoc
class _$PreloadedListModelCopyWithImpl<$Res, $Val extends PreloadedListModel>
    implements $PreloadedListModelCopyWith<$Res> {
  _$PreloadedListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? preloaded_photo = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preloaded_photo: null == preloaded_photo
          ? _value.preloaded_photo
          : preloaded_photo // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreloadedListModelCopyWith<$Res>
    implements $PreloadedListModelCopyWith<$Res> {
  factory _$$_PreloadedListModelCopyWith(_$_PreloadedListModel value,
          $Res Function(_$_PreloadedListModel) then) =
      __$$_PreloadedListModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String preloaded_photo, String description});
}

/// @nodoc
class __$$_PreloadedListModelCopyWithImpl<$Res>
    extends _$PreloadedListModelCopyWithImpl<$Res, _$_PreloadedListModel>
    implements _$$_PreloadedListModelCopyWith<$Res> {
  __$$_PreloadedListModelCopyWithImpl(
      _$_PreloadedListModel _value, $Res Function(_$_PreloadedListModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? preloaded_photo = null,
    Object? description = null,
  }) {
    return _then(_$_PreloadedListModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preloaded_photo: null == preloaded_photo
          ? _value.preloaded_photo
          : preloaded_photo // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreloadedListModel implements _PreloadedListModel {
  const _$_PreloadedListModel(
      {required this.name,
      required this.preloaded_photo,
      required this.description});

  factory _$_PreloadedListModel.fromJson(Map<String, dynamic> json) =>
      _$$_PreloadedListModelFromJson(json);

  @override
  final String name;
  @override
  final String preloaded_photo;
  @override
  final String description;

  @override
  String toString() {
    return 'PreloadedListModel(name: $name, preloaded_photo: $preloaded_photo, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreloadedListModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.preloaded_photo, preloaded_photo) ||
                other.preloaded_photo == preloaded_photo) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, preloaded_photo, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreloadedListModelCopyWith<_$_PreloadedListModel> get copyWith =>
      __$$_PreloadedListModelCopyWithImpl<_$_PreloadedListModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PreloadedListModelToJson(
      this,
    );
  }
}

abstract class _PreloadedListModel implements PreloadedListModel {
  const factory _PreloadedListModel(
      {required final String name,
      required final String preloaded_photo,
      required final String description}) = _$_PreloadedListModel;

  factory _PreloadedListModel.fromJson(Map<String, dynamic> json) =
      _$_PreloadedListModel.fromJson;

  @override
  String get name;
  @override
  String get preloaded_photo;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_PreloadedListModelCopyWith<_$_PreloadedListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
