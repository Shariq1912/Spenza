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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "preloaded_photo")
  String get preloadedPhoto => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

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
  $Res call(
      {String id,
      String name,
      @JsonKey(name: "preloaded_photo") String preloadedPhoto,
      String description,
      String path});
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
    Object? id = null,
    Object? name = null,
    Object? preloadedPhoto = null,
    Object? description = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preloadedPhoto: null == preloadedPhoto
          ? _value.preloadedPhoto
          : preloadedPhoto // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {String id,
      String name,
      @JsonKey(name: "preloaded_photo") String preloadedPhoto,
      String description,
      String path});
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
    Object? id = null,
    Object? name = null,
    Object? preloadedPhoto = null,
    Object? description = null,
    Object? path = null,
  }) {
    return _then(_$_PreloadedListModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      preloadedPhoto: null == preloadedPhoto
          ? _value.preloadedPhoto
          : preloadedPhoto // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PreloadedListModel implements _PreloadedListModel {
  const _$_PreloadedListModel(
      {required this.id,
      required this.name,
      @JsonKey(name: "preloaded_photo") required this.preloadedPhoto,
      required this.description,
      required this.path});

  factory _$_PreloadedListModel.fromJson(Map<String, dynamic> json) =>
      _$$_PreloadedListModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: "preloaded_photo")
  final String preloadedPhoto;
  @override
  final String description;
  @override
  final String path;

  @override
  String toString() {
    return 'PreloadedListModel(id: $id, name: $name, preloadedPhoto: $preloadedPhoto, description: $description, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreloadedListModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.preloadedPhoto, preloadedPhoto) ||
                other.preloadedPhoto == preloadedPhoto) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, preloadedPhoto, description, path);

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
      {required final String id,
      required final String name,
      @JsonKey(name: "preloaded_photo") required final String preloadedPhoto,
      required final String description,
      required final String path}) = _$_PreloadedListModel;

  factory _PreloadedListModel.fromJson(Map<String, dynamic> json) =
      _$_PreloadedListModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: "preloaded_photo")
  String get preloadedPhoto;
  @override
  String get description;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_PreloadedListModelCopyWith<_$_PreloadedListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
