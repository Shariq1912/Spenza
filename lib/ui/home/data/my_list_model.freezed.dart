// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyListModel _$MyListModelFromJson(Map<String, dynamic> json) {
  return _MyListModel.fromJson(json);
}

/// @nodoc
mixin _$MyListModel {
  String get description => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get usersRef => throw _privateConstructorUsedError;
  String? get myListPhoto => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyListModelCopyWith<MyListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyListModelCopyWith<$Res> {
  factory $MyListModelCopyWith(
          MyListModel value, $Res Function(MyListModel) then) =
      _$MyListModelCopyWithImpl<$Res, MyListModel>;
  @useResult
  $Res call(
      {String description,
      String name,
      String uid,
      String usersRef,
      String? myListPhoto,
      String? documentId});
}

/// @nodoc
class _$MyListModelCopyWithImpl<$Res, $Val extends MyListModel>
    implements $MyListModelCopyWith<$Res> {
  _$MyListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? name = null,
    Object? uid = null,
    Object? usersRef = null,
    Object? myListPhoto = freezed,
    Object? documentId = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      usersRef: null == usersRef
          ? _value.usersRef
          : usersRef // ignore: cast_nullable_to_non_nullable
              as String,
      myListPhoto: freezed == myListPhoto
          ? _value.myListPhoto
          : myListPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyListModelCopyWith<$Res>
    implements $MyListModelCopyWith<$Res> {
  factory _$$_MyListModelCopyWith(
          _$_MyListModel value, $Res Function(_$_MyListModel) then) =
      __$$_MyListModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String name,
      String uid,
      String usersRef,
      String? myListPhoto,
      String? documentId});
}

/// @nodoc
class __$$_MyListModelCopyWithImpl<$Res>
    extends _$MyListModelCopyWithImpl<$Res, _$_MyListModel>
    implements _$$_MyListModelCopyWith<$Res> {
  __$$_MyListModelCopyWithImpl(
      _$_MyListModel _value, $Res Function(_$_MyListModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? name = null,
    Object? uid = null,
    Object? usersRef = null,
    Object? myListPhoto = freezed,
    Object? documentId = freezed,
  }) {
    return _then(_$_MyListModel(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      usersRef: null == usersRef
          ? _value.usersRef
          : usersRef // ignore: cast_nullable_to_non_nullable
              as String,
      myListPhoto: freezed == myListPhoto
          ? _value.myListPhoto
          : myListPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyListModel implements _MyListModel {
  const _$_MyListModel(
      {required this.description,
      required this.name,
      required this.uid,
      required this.usersRef,
      this.myListPhoto,
      this.documentId = null});

  factory _$_MyListModel.fromJson(Map<String, dynamic> json) =>
      _$$_MyListModelFromJson(json);

  @override
  final String description;
  @override
  final String name;
  @override
  final String uid;
  @override
  final String usersRef;
  @override
  final String? myListPhoto;
  @override
  @JsonKey()
  final String? documentId;

  @override
  String toString() {
    return 'MyListModel(description: $description, name: $name, uid: $uid, usersRef: $usersRef, myListPhoto: $myListPhoto, documentId: $documentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyListModel &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.usersRef, usersRef) ||
                other.usersRef == usersRef) &&
            (identical(other.myListPhoto, myListPhoto) ||
                other.myListPhoto == myListPhoto) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, name, uid, usersRef, myListPhoto, documentId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyListModelCopyWith<_$_MyListModel> get copyWith =>
      __$$_MyListModelCopyWithImpl<_$_MyListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyListModelToJson(
      this,
    );
  }
}

abstract class _MyListModel implements MyListModel {
  const factory _MyListModel(
      {required final String description,
      required final String name,
      required final String uid,
      required final String usersRef,
      final String? myListPhoto,
      final String? documentId}) = _$_MyListModel;

  factory _MyListModel.fromJson(Map<String, dynamic> json) =
      _$_MyListModel.fromJson;

  @override
  String get description;
  @override
  String get name;
  @override
  String get uid;
  @override
  String get usersRef;
  @override
  String? get myListPhoto;
  @override
  String? get documentId;
  @override
  @JsonKey(ignore: true)
  _$$_MyListModelCopyWith<_$_MyListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
