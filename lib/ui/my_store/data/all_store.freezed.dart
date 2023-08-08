// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllStores _$AllStoresFromJson(Map<String, dynamic> json) {
  return _AllStores.fromJson(json);
}

/// @nodoc
mixin _$AllStores {
  String get name => throw _privateConstructorUsedError;
  String get adress => throw _privateConstructorUsedError;
  List<String> get zipCodesList => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllStoresCopyWith<AllStores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllStoresCopyWith<$Res> {
  factory $AllStoresCopyWith(AllStores value, $Res Function(AllStores) then) =
      _$AllStoresCopyWithImpl<$Res, AllStores>;
  @useResult
  $Res call(
      {String name,
      String adress,
      List<String> zipCodesList,
      String logo,
      bool isFavorite,
      String? documentId,
      String groupName});
}

/// @nodoc
class _$AllStoresCopyWithImpl<$Res, $Val extends AllStores>
    implements $AllStoresCopyWith<$Res> {
  _$AllStoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? adress = null,
    Object? zipCodesList = null,
    Object? logo = null,
    Object? isFavorite = null,
    Object? documentId = freezed,
    Object? groupName = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adress: null == adress
          ? _value.adress
          : adress // ignore: cast_nullable_to_non_nullable
              as String,
      zipCodesList: null == zipCodesList
          ? _value.zipCodesList
          : zipCodesList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AllStoresCopyWith<$Res> implements $AllStoresCopyWith<$Res> {
  factory _$$_AllStoresCopyWith(
          _$_AllStores value, $Res Function(_$_AllStores) then) =
      __$$_AllStoresCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String adress,
      List<String> zipCodesList,
      String logo,
      bool isFavorite,
      String? documentId,
      String groupName});
}

/// @nodoc
class __$$_AllStoresCopyWithImpl<$Res>
    extends _$AllStoresCopyWithImpl<$Res, _$_AllStores>
    implements _$$_AllStoresCopyWith<$Res> {
  __$$_AllStoresCopyWithImpl(
      _$_AllStores _value, $Res Function(_$_AllStores) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? adress = null,
    Object? zipCodesList = null,
    Object? logo = null,
    Object? isFavorite = null,
    Object? documentId = freezed,
    Object? groupName = null,
  }) {
    return _then(_$_AllStores(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adress: null == adress
          ? _value.adress
          : adress // ignore: cast_nullable_to_non_nullable
              as String,
      zipCodesList: null == zipCodesList
          ? _value._zipCodesList
          : zipCodesList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllStores with DiagnosticableTreeMixin implements _AllStores {
  const _$_AllStores(
      {required this.name,
      required this.adress,
      required final List<String> zipCodesList,
      required this.logo,
      this.isFavorite = false,
      this.documentId,
      required this.groupName})
      : _zipCodesList = zipCodesList;

  factory _$_AllStores.fromJson(Map<String, dynamic> json) =>
      _$$_AllStoresFromJson(json);

  @override
  final String name;
  @override
  final String adress;
  final List<String> _zipCodesList;
  @override
  List<String> get zipCodesList {
    if (_zipCodesList is EqualUnmodifiableListView) return _zipCodesList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zipCodesList);
  }

  @override
  final String logo;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final String? documentId;
  @override
  final String groupName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AllStores(name: $name, adress: $adress, zipCodesList: $zipCodesList, logo: $logo, isFavorite: $isFavorite, documentId: $documentId, groupName: $groupName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AllStores'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('adress', adress))
      ..add(DiagnosticsProperty('zipCodesList', zipCodesList))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('isFavorite', isFavorite))
      ..add(DiagnosticsProperty('documentId', documentId))
      ..add(DiagnosticsProperty('groupName', groupName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllStores &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adress, adress) || other.adress == adress) &&
            const DeepCollectionEquality()
                .equals(other._zipCodesList, _zipCodesList) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      adress,
      const DeepCollectionEquality().hash(_zipCodesList),
      logo,
      isFavorite,
      documentId,
      groupName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AllStoresCopyWith<_$_AllStores> get copyWith =>
      __$$_AllStoresCopyWithImpl<_$_AllStores>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllStoresToJson(
      this,
    );
  }
}

abstract class _AllStores implements AllStores {
  const factory _AllStores(
      {required final String name,
      required final String adress,
      required final List<String> zipCodesList,
      required final String logo,
      final bool isFavorite,
      final String? documentId,
      required final String groupName}) = _$_AllStores;

  factory _AllStores.fromJson(Map<String, dynamic> json) =
      _$_AllStores.fromJson;

  @override
  String get name;
  @override
  String get adress;
  @override
  List<String> get zipCodesList;
  @override
  String get logo;
  @override
  bool get isFavorite;
  @override
  String? get documentId;
  @override
  String get groupName;
  @override
  @JsonKey(ignore: true)
  _$$_AllStoresCopyWith<_$_AllStores> get copyWith =>
      throw _privateConstructorUsedError;
}
