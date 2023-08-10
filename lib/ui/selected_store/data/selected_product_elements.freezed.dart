// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_product_elements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelectedProductElement _$SelectedProductElementFromJson(
    Map<String, dynamic> json) {
  return _SelectedProductElement.fromJson(json);
}

/// @nodoc
mixin _$SelectedProductElement {
  String get measure => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "product_image")
  String get productImage => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelectedProductElementCopyWith<SelectedProductElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedProductElementCopyWith<$Res> {
  factory $SelectedProductElementCopyWith(SelectedProductElement value,
          $Res Function(SelectedProductElement) then) =
      _$SelectedProductElementCopyWithImpl<$Res, SelectedProductElement>;
  @useResult
  $Res call(
      {String measure,
      String name,
      @JsonKey(name: "product_image") String productImage,
      double price,
      int quantity});
}

/// @nodoc
class _$SelectedProductElementCopyWithImpl<$Res,
        $Val extends SelectedProductElement>
    implements $SelectedProductElementCopyWith<$Res> {
  _$SelectedProductElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measure = null,
    Object? name = null,
    Object? productImage = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectedProductElementCopyWith<$Res>
    implements $SelectedProductElementCopyWith<$Res> {
  factory _$$_SelectedProductElementCopyWith(_$_SelectedProductElement value,
          $Res Function(_$_SelectedProductElement) then) =
      __$$_SelectedProductElementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String measure,
      String name,
      @JsonKey(name: "product_image") String productImage,
      double price,
      int quantity});
}

/// @nodoc
class __$$_SelectedProductElementCopyWithImpl<$Res>
    extends _$SelectedProductElementCopyWithImpl<$Res,
        _$_SelectedProductElement>
    implements _$$_SelectedProductElementCopyWith<$Res> {
  __$$_SelectedProductElementCopyWithImpl(_$_SelectedProductElement _value,
      $Res Function(_$_SelectedProductElement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measure = null,
    Object? name = null,
    Object? productImage = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_$_SelectedProductElement(
      measure: null == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelectedProductElement
    with DiagnosticableTreeMixin
    implements _SelectedProductElement {
  const _$_SelectedProductElement(
      {required this.measure,
      required this.name,
      @JsonKey(name: "product_image") required this.productImage,
      required this.price,
      required this.quantity});

  factory _$_SelectedProductElement.fromJson(Map<String, dynamic> json) =>
      _$$_SelectedProductElementFromJson(json);

  @override
  final String measure;
  @override
  final String name;
  @override
  @JsonKey(name: "product_image")
  final String productImage;
  @override
  final double price;
  @override
  final int quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProductElement(measure: $measure, name: $name, productImage: $productImage, price: $price, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProductElement'))
      ..add(DiagnosticsProperty('measure', measure))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('productImage', productImage))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectedProductElement &&
            (identical(other.measure, measure) || other.measure == measure) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, measure, name, productImage, price, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedProductElementCopyWith<_$_SelectedProductElement> get copyWith =>
      __$$_SelectedProductElementCopyWithImpl<_$_SelectedProductElement>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelectedProductElementToJson(
      this,
    );
  }
}

abstract class _SelectedProductElement implements SelectedProductElement {
  const factory _SelectedProductElement(
      {required final String measure,
      required final String name,
      @JsonKey(name: "product_image") required final String productImage,
      required final double price,
      required final int quantity}) = _$_SelectedProductElement;

  factory _SelectedProductElement.fromJson(Map<String, dynamic> json) =
      _$_SelectedProductElement.fromJson;

  @override
  String get measure;
  @override
  String get name;
  @override
  @JsonKey(name: "product_image")
  String get productImage;
  @override
  double get price;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_SelectedProductElementCopyWith<_$_SelectedProductElement> get copyWith =>
      throw _privateConstructorUsedError;
}
