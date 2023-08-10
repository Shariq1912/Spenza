// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProduct _$UserProductFromJson(Map<String, dynamic> json) {
  return _UserProduct.fromJson(json);
}

/// @nodoc
mixin _$UserProduct {
  String get productId => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get pImage => throw _privateConstructorUsedError;
  String get measure => throw _privateConstructorUsedError;
  String get minPrice => throw _privateConstructorUsedError;
  String get maxPrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProductCopyWith<UserProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductCopyWith<$Res> {
  factory $UserProductCopyWith(
          UserProduct value, $Res Function(UserProduct) then) =
      _$UserProductCopyWithImpl<$Res, UserProduct>;
  @useResult
  $Res call(
      {String productId,
      String department,
      String name,
      String pImage,
      String measure,
      String minPrice,
      String maxPrice,
      int quantity});
}

/// @nodoc
class _$UserProductCopyWithImpl<$Res, $Val extends UserProduct>
    implements $UserProductCopyWith<$Res> {
  _$UserProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? department = null,
    Object? name = null,
    Object? pImage = null,
    Object? measure = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pImage: null == pImage
          ? _value.pImage
          : pImage // ignore: cast_nullable_to_non_nullable
              as String,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserProductCopyWith<$Res>
    implements $UserProductCopyWith<$Res> {
  factory _$$_UserProductCopyWith(
          _$_UserProduct value, $Res Function(_$_UserProduct) then) =
      __$$_UserProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String department,
      String name,
      String pImage,
      String measure,
      String minPrice,
      String maxPrice,
      int quantity});
}

/// @nodoc
class __$$_UserProductCopyWithImpl<$Res>
    extends _$UserProductCopyWithImpl<$Res, _$_UserProduct>
    implements _$$_UserProductCopyWith<$Res> {
  __$$_UserProductCopyWithImpl(
      _$_UserProduct _value, $Res Function(_$_UserProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? department = null,
    Object? name = null,
    Object? pImage = null,
    Object? measure = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? quantity = null,
  }) {
    return _then(_$_UserProduct(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pImage: null == pImage
          ? _value.pImage
          : pImage // ignore: cast_nullable_to_non_nullable
              as String,
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as String,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@DocumentReferenceJsonConverter()
class _$_UserProduct with DiagnosticableTreeMixin implements _UserProduct {
  const _$_UserProduct(
      {required this.productId,
      required this.department,
      required this.name,
      required this.pImage,
      required this.measure,
      required this.minPrice,
      required this.maxPrice,
      this.quantity = 1});

  factory _$_UserProduct.fromJson(Map<String, dynamic> json) =>
      _$$_UserProductFromJson(json);

  @override
  final String productId;
  @override
  final String department;
  @override
  final String name;
  @override
  final String pImage;
  @override
  final String measure;
  @override
  final String minPrice;
  @override
  final String maxPrice;
  @override
  @JsonKey()
  final int quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProduct(productId: $productId, department: $department, name: $name, pImage: $pImage, measure: $measure, minPrice: $minPrice, maxPrice: $maxPrice, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserProduct'))
      ..add(DiagnosticsProperty('productId', productId))
      ..add(DiagnosticsProperty('department', department))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('pImage', pImage))
      ..add(DiagnosticsProperty('measure', measure))
      ..add(DiagnosticsProperty('minPrice', minPrice))
      ..add(DiagnosticsProperty('maxPrice', maxPrice))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProduct &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pImage, pImage) || other.pImage == pImage) &&
            (identical(other.measure, measure) || other.measure == measure) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId, department, name,
      pImage, measure, minPrice, maxPrice, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProductCopyWith<_$_UserProduct> get copyWith =>
      __$$_UserProductCopyWithImpl<_$_UserProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProductToJson(
      this,
    );
  }
}

abstract class _UserProduct implements UserProduct {
  const factory _UserProduct(
      {required final String productId,
      required final String department,
      required final String name,
      required final String pImage,
      required final String measure,
      required final String minPrice,
      required final String maxPrice,
      final int quantity}) = _$_UserProduct;

  factory _UserProduct.fromJson(Map<String, dynamic> json) =
      _$_UserProduct.fromJson;

  @override
  String get productId;
  @override
  String get department;
  @override
  String get name;
  @override
  String get pImage;
  @override
  String get measure;
  @override
  String get minPrice;
  @override
  String get maxPrice;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_UserProductCopyWith<_$_UserProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
