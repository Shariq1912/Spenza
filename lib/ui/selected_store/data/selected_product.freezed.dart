// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelectedProduct _$SelectedProductFromJson(Map<String, dynamic> json) {
  return _SelectedProduct.fromJson(json);
}

/// @nodoc
mixin _$SelectedProduct {
  DocumentReference<Object?>? get storeRef =>
      throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<SelectedProductList> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelectedProductCopyWith<SelectedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedProductCopyWith<$Res> {
  factory $SelectedProductCopyWith(
          SelectedProduct value, $Res Function(SelectedProduct) then) =
      _$SelectedProductCopyWithImpl<$Res, SelectedProduct>;
  @useResult
  $Res call(
      {DocumentReference<Object?>? storeRef,
      double total,
      List<SelectedProductList> products});
}

/// @nodoc
class _$SelectedProductCopyWithImpl<$Res, $Val extends SelectedProduct>
    implements $SelectedProductCopyWith<$Res> {
  _$SelectedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeRef = freezed,
    Object? total = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      storeRef: freezed == storeRef
          ? _value.storeRef
          : storeRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<SelectedProductList>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectedProductCopyWith<$Res>
    implements $SelectedProductCopyWith<$Res> {
  factory _$$_SelectedProductCopyWith(
          _$_SelectedProduct value, $Res Function(_$_SelectedProduct) then) =
      __$$_SelectedProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DocumentReference<Object?>? storeRef,
      double total,
      List<SelectedProductList> products});
}

/// @nodoc
class __$$_SelectedProductCopyWithImpl<$Res>
    extends _$SelectedProductCopyWithImpl<$Res, _$_SelectedProduct>
    implements _$$_SelectedProductCopyWith<$Res> {
  __$$_SelectedProductCopyWithImpl(
      _$_SelectedProduct _value, $Res Function(_$_SelectedProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeRef = freezed,
    Object? total = null,
    Object? products = null,
  }) {
    return _then(_$_SelectedProduct(
      storeRef: freezed == storeRef
          ? _value.storeRef
          : storeRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<SelectedProductList>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@DocumentReferenceJsonConverter()
class _$_SelectedProduct
    with DiagnosticableTreeMixin
    implements _SelectedProduct {
  const _$_SelectedProduct(
      {this.storeRef,
      this.total = 0.0,
      final List<SelectedProductList> products = const []})
      : _products = products;

  factory _$_SelectedProduct.fromJson(Map<String, dynamic> json) =>
      _$$_SelectedProductFromJson(json);

  @override
  final DocumentReference<Object?>? storeRef;
  @override
  @JsonKey()
  final double total;
  final List<SelectedProductList> _products;
  @override
  @JsonKey()
  List<SelectedProductList> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProduct(storeRef: $storeRef, total: $total, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProduct'))
      ..add(DiagnosticsProperty('storeRef', storeRef))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectedProduct &&
            (identical(other.storeRef, storeRef) ||
                other.storeRef == storeRef) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, storeRef, total,
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedProductCopyWith<_$_SelectedProduct> get copyWith =>
      __$$_SelectedProductCopyWithImpl<_$_SelectedProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelectedProductToJson(
      this,
    );
  }
}

abstract class _SelectedProduct implements SelectedProduct {
  const factory _SelectedProduct(
      {final DocumentReference<Object?>? storeRef,
      final double total,
      final List<SelectedProductList> products}) = _$_SelectedProduct;

  factory _SelectedProduct.fromJson(Map<String, dynamic> json) =
      _$_SelectedProduct.fromJson;

  @override
  DocumentReference<Object?>? get storeRef;
  @override
  double get total;
  @override
  List<SelectedProductList> get products;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedProductCopyWith<_$_SelectedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
