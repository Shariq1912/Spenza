// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_stores.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Stores _$StoresFromJson(Map<String, dynamic> json) {
  return _Stores.fromJson(json);
}

/// @nodoc
mixin _$Stores {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<String> get zipCodesList => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoresCopyWith<Stores> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoresCopyWith<$Res> {
  factory $StoresCopyWith(Stores value, $Res Function(Stores) then) =
      _$StoresCopyWithImpl<$Res, Stores>;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      List<String> zipCodesList,
      String logo,
      bool isFavorite});
}

/// @nodoc
class _$StoresCopyWithImpl<$Res, $Val extends Stores>
    implements $StoresCopyWith<$Res> {
  _$StoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? zipCodesList = null,
    Object? logo = null,
    Object? isFavorite = null,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoresCopyWith<$Res> implements $StoresCopyWith<$Res> {
  factory _$$_StoresCopyWith(_$_Stores value, $Res Function(_$_Stores) then) =
      __$$_StoresCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      List<String> zipCodesList,
      String logo,
      bool isFavorite});
}

/// @nodoc
class __$$_StoresCopyWithImpl<$Res>
    extends _$StoresCopyWithImpl<$Res, _$_Stores>
    implements _$$_StoresCopyWith<$Res> {
  __$$_StoresCopyWithImpl(_$_Stores _value, $Res Function(_$_Stores) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? zipCodesList = null,
    Object? logo = null,
    Object? isFavorite = null,
  }) {
    return _then(_$_Stores(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Stores with DiagnosticableTreeMixin implements _Stores {
  const _$_Stores(
      {this.id = "",
      required this.name,
      required this.address,
      required final List<String> zipCodesList,
      required this.logo,
      this.isFavorite = false})
      : _zipCodesList = zipCodesList;

  factory _$_Stores.fromJson(Map<String, dynamic> json) =>
      _$$_StoresFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String name;
  @override
  final String address;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Stores(id: $id, name: $name, address: $address, zipCodesList: $zipCodesList, logo: $logo, isFavorite: $isFavorite)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Stores'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('zipCodesList', zipCodesList))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('isFavorite', isFavorite));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Stores &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._zipCodesList, _zipCodesList) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address,
      const DeepCollectionEquality().hash(_zipCodesList), logo, isFavorite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoresCopyWith<_$_Stores> get copyWith =>
      __$$_StoresCopyWithImpl<_$_Stores>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoresToJson(
      this,
    );
  }
}

abstract class _Stores implements Stores {
  const factory _Stores(
      {final String id,
      required final String name,
      required final String address,
      required final List<String> zipCodesList,
      required final String logo,
      final bool isFavorite}) = _$_Stores;

  factory _Stores.fromJson(Map<String, dynamic> json) = _$_Stores.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  List<String> get zipCodesList;
  @override
  String get logo;
  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$_StoresCopyWith<_$_Stores> get copyWith =>
      throw _privateConstructorUsedError;
}
