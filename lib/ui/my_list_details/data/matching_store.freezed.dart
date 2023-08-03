// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matching_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchingStores _$MatchingStoresFromJson(Map<String, dynamic> json) {
  return _MatchingStore.fromJson(json);
}

/// @nodoc
mixin _$MatchingStores {
  String get logo => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get matchingPercentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchingStoresCopyWith<MatchingStores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingStoresCopyWith<$Res> {
  factory $MatchingStoresCopyWith(
          MatchingStores value, $Res Function(MatchingStores) then) =
      _$MatchingStoresCopyWithImpl<$Res, MatchingStores>;
  @useResult
  $Res call(
      {String logo,
      String name,
      double totalPrice,
      String distance,
      String address,
      int matchingPercentage});
}

/// @nodoc
class _$MatchingStoresCopyWithImpl<$Res, $Val extends MatchingStores>
    implements $MatchingStoresCopyWith<$Res> {
  _$MatchingStoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logo = null,
    Object? name = null,
    Object? totalPrice = null,
    Object? distance = null,
    Object? address = null,
    Object? matchingPercentage = null,
  }) {
    return _then(_value.copyWith(
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      matchingPercentage: null == matchingPercentage
          ? _value.matchingPercentage
          : matchingPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchingStoreCopyWith<$Res>
    implements $MatchingStoresCopyWith<$Res> {
  factory _$$_MatchingStoreCopyWith(
          _$_MatchingStore value, $Res Function(_$_MatchingStore) then) =
      __$$_MatchingStoreCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String logo,
      String name,
      double totalPrice,
      String distance,
      String address,
      int matchingPercentage});
}

/// @nodoc
class __$$_MatchingStoreCopyWithImpl<$Res>
    extends _$MatchingStoresCopyWithImpl<$Res, _$_MatchingStore>
    implements _$$_MatchingStoreCopyWith<$Res> {
  __$$_MatchingStoreCopyWithImpl(
      _$_MatchingStore _value, $Res Function(_$_MatchingStore) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logo = null,
    Object? name = null,
    Object? totalPrice = null,
    Object? distance = null,
    Object? address = null,
    Object? matchingPercentage = null,
  }) {
    return _then(_$_MatchingStore(
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      matchingPercentage: null == matchingPercentage
          ? _value.matchingPercentage
          : matchingPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchingStore with DiagnosticableTreeMixin implements _MatchingStore {
  const _$_MatchingStore(
      {required this.logo,
      required this.name,
      required this.totalPrice,
      required this.distance,
      required this.address,
      required this.matchingPercentage});

  factory _$_MatchingStore.fromJson(Map<String, dynamic> json) =>
      _$$_MatchingStoreFromJson(json);

  @override
  final String logo;
  @override
  final String name;
  @override
  final double totalPrice;
  @override
  final String distance;
  @override
  final String address;
  @override
  final int matchingPercentage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MatchingStores(logo: $logo, name: $name, totalPrice: $totalPrice, distance: $distance, address: $address, matchingPercentage: $matchingPercentage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MatchingStores'))
      ..add(DiagnosticsProperty('logo', logo))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('totalPrice', totalPrice))
      ..add(DiagnosticsProperty('distance', distance))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('matchingPercentage', matchingPercentage));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchingStore &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.matchingPercentage, matchingPercentage) ||
                other.matchingPercentage == matchingPercentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, logo, name, totalPrice, distance,
      address, matchingPercentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchingStoreCopyWith<_$_MatchingStore> get copyWith =>
      __$$_MatchingStoreCopyWithImpl<_$_MatchingStore>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchingStoreToJson(
      this,
    );
  }
}

abstract class _MatchingStore implements MatchingStores {
  const factory _MatchingStore(
      {required final String logo,
      required final String name,
      required final double totalPrice,
      required final String distance,
      required final String address,
      required final int matchingPercentage}) = _$_MatchingStore;

  factory _MatchingStore.fromJson(Map<String, dynamic> json) =
      _$_MatchingStore.fromJson;

  @override
  String get logo;
  @override
  String get name;
  @override
  double get totalPrice;
  @override
  String get distance;
  @override
  String get address;
  @override
  int get matchingPercentage;
  @override
  @JsonKey(ignore: true)
  _$$_MatchingStoreCopyWith<_$_MatchingStore> get copyWith =>
      throw _privateConstructorUsedError;
}
