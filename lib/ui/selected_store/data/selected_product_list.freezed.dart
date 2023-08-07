// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_product_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelectedProductList _$SelectedProductListFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'similarProduct':
      return SimilarProduct.fromJson(json);
    case 'missingProduct':
      return MissingProduct.fromJson(json);
    case 'exactProduct':
      return ExactProduct.fromJson(json);
    case 'label':
      return Label.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SelectedProductList',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SelectedProductList {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SelectedProductElement product) similarProduct,
    required TResult Function(SelectedProductElement product) missingProduct,
    required TResult Function(SelectedProductElement product) exactProduct,
    required TResult Function(String label) label,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SelectedProductElement product)? similarProduct,
    TResult? Function(SelectedProductElement product)? missingProduct,
    TResult? Function(SelectedProductElement product)? exactProduct,
    TResult? Function(String label)? label,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SelectedProductElement product)? similarProduct,
    TResult Function(SelectedProductElement product)? missingProduct,
    TResult Function(SelectedProductElement product)? exactProduct,
    TResult Function(String label)? label,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimilarProduct value) similarProduct,
    required TResult Function(MissingProduct value) missingProduct,
    required TResult Function(ExactProduct value) exactProduct,
    required TResult Function(Label value) label,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimilarProduct value)? similarProduct,
    TResult? Function(MissingProduct value)? missingProduct,
    TResult? Function(ExactProduct value)? exactProduct,
    TResult? Function(Label value)? label,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimilarProduct value)? similarProduct,
    TResult Function(MissingProduct value)? missingProduct,
    TResult Function(ExactProduct value)? exactProduct,
    TResult Function(Label value)? label,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedProductListCopyWith<$Res> {
  factory $SelectedProductListCopyWith(
          SelectedProductList value, $Res Function(SelectedProductList) then) =
      _$SelectedProductListCopyWithImpl<$Res, SelectedProductList>;
}

/// @nodoc
class _$SelectedProductListCopyWithImpl<$Res, $Val extends SelectedProductList>
    implements $SelectedProductListCopyWith<$Res> {
  _$SelectedProductListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SimilarProductCopyWith<$Res> {
  factory _$$SimilarProductCopyWith(
          _$SimilarProduct value, $Res Function(_$SimilarProduct) then) =
      __$$SimilarProductCopyWithImpl<$Res>;
  @useResult
  $Res call({SelectedProductElement product});

  $SelectedProductElementCopyWith<$Res> get product;
}

/// @nodoc
class __$$SimilarProductCopyWithImpl<$Res>
    extends _$SelectedProductListCopyWithImpl<$Res, _$SimilarProduct>
    implements _$$SimilarProductCopyWith<$Res> {
  __$$SimilarProductCopyWithImpl(
      _$SimilarProduct _value, $Res Function(_$SimilarProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$SimilarProduct(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as SelectedProductElement,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SelectedProductElementCopyWith<$Res> get product {
    return $SelectedProductElementCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SimilarProduct with DiagnosticableTreeMixin implements SimilarProduct {
  const _$SimilarProduct({required this.product, final String? $type})
      : $type = $type ?? 'similarProduct';

  factory _$SimilarProduct.fromJson(Map<String, dynamic> json) =>
      _$$SimilarProductFromJson(json);

  @override
  final SelectedProductElement product;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProductList.similarProduct(product: $product)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProductList.similarProduct'))
      ..add(DiagnosticsProperty('product', product));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimilarProduct &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SimilarProductCopyWith<_$SimilarProduct> get copyWith =>
      __$$SimilarProductCopyWithImpl<_$SimilarProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SelectedProductElement product) similarProduct,
    required TResult Function(SelectedProductElement product) missingProduct,
    required TResult Function(SelectedProductElement product) exactProduct,
    required TResult Function(String label) label,
  }) {
    return similarProduct(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SelectedProductElement product)? similarProduct,
    TResult? Function(SelectedProductElement product)? missingProduct,
    TResult? Function(SelectedProductElement product)? exactProduct,
    TResult? Function(String label)? label,
  }) {
    return similarProduct?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SelectedProductElement product)? similarProduct,
    TResult Function(SelectedProductElement product)? missingProduct,
    TResult Function(SelectedProductElement product)? exactProduct,
    TResult Function(String label)? label,
    required TResult orElse(),
  }) {
    if (similarProduct != null) {
      return similarProduct(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimilarProduct value) similarProduct,
    required TResult Function(MissingProduct value) missingProduct,
    required TResult Function(ExactProduct value) exactProduct,
    required TResult Function(Label value) label,
  }) {
    return similarProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimilarProduct value)? similarProduct,
    TResult? Function(MissingProduct value)? missingProduct,
    TResult? Function(ExactProduct value)? exactProduct,
    TResult? Function(Label value)? label,
  }) {
    return similarProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimilarProduct value)? similarProduct,
    TResult Function(MissingProduct value)? missingProduct,
    TResult Function(ExactProduct value)? exactProduct,
    TResult Function(Label value)? label,
    required TResult orElse(),
  }) {
    if (similarProduct != null) {
      return similarProduct(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SimilarProductToJson(
      this,
    );
  }
}

abstract class SimilarProduct implements SelectedProductList {
  const factory SimilarProduct(
      {required final SelectedProductElement product}) = _$SimilarProduct;

  factory SimilarProduct.fromJson(Map<String, dynamic> json) =
      _$SimilarProduct.fromJson;

  SelectedProductElement get product;
  @JsonKey(ignore: true)
  _$$SimilarProductCopyWith<_$SimilarProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MissingProductCopyWith<$Res> {
  factory _$$MissingProductCopyWith(
          _$MissingProduct value, $Res Function(_$MissingProduct) then) =
      __$$MissingProductCopyWithImpl<$Res>;
  @useResult
  $Res call({SelectedProductElement product});

  $SelectedProductElementCopyWith<$Res> get product;
}

/// @nodoc
class __$$MissingProductCopyWithImpl<$Res>
    extends _$SelectedProductListCopyWithImpl<$Res, _$MissingProduct>
    implements _$$MissingProductCopyWith<$Res> {
  __$$MissingProductCopyWithImpl(
      _$MissingProduct _value, $Res Function(_$MissingProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$MissingProduct(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as SelectedProductElement,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SelectedProductElementCopyWith<$Res> get product {
    return $SelectedProductElementCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$MissingProduct with DiagnosticableTreeMixin implements MissingProduct {
  const _$MissingProduct({required this.product, final String? $type})
      : $type = $type ?? 'missingProduct';

  factory _$MissingProduct.fromJson(Map<String, dynamic> json) =>
      _$$MissingProductFromJson(json);

  @override
  final SelectedProductElement product;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProductList.missingProduct(product: $product)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProductList.missingProduct'))
      ..add(DiagnosticsProperty('product', product));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissingProduct &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissingProductCopyWith<_$MissingProduct> get copyWith =>
      __$$MissingProductCopyWithImpl<_$MissingProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SelectedProductElement product) similarProduct,
    required TResult Function(SelectedProductElement product) missingProduct,
    required TResult Function(SelectedProductElement product) exactProduct,
    required TResult Function(String label) label,
  }) {
    return missingProduct(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SelectedProductElement product)? similarProduct,
    TResult? Function(SelectedProductElement product)? missingProduct,
    TResult? Function(SelectedProductElement product)? exactProduct,
    TResult? Function(String label)? label,
  }) {
    return missingProduct?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SelectedProductElement product)? similarProduct,
    TResult Function(SelectedProductElement product)? missingProduct,
    TResult Function(SelectedProductElement product)? exactProduct,
    TResult Function(String label)? label,
    required TResult orElse(),
  }) {
    if (missingProduct != null) {
      return missingProduct(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimilarProduct value) similarProduct,
    required TResult Function(MissingProduct value) missingProduct,
    required TResult Function(ExactProduct value) exactProduct,
    required TResult Function(Label value) label,
  }) {
    return missingProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimilarProduct value)? similarProduct,
    TResult? Function(MissingProduct value)? missingProduct,
    TResult? Function(ExactProduct value)? exactProduct,
    TResult? Function(Label value)? label,
  }) {
    return missingProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimilarProduct value)? similarProduct,
    TResult Function(MissingProduct value)? missingProduct,
    TResult Function(ExactProduct value)? exactProduct,
    TResult Function(Label value)? label,
    required TResult orElse(),
  }) {
    if (missingProduct != null) {
      return missingProduct(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MissingProductToJson(
      this,
    );
  }
}

abstract class MissingProduct implements SelectedProductList {
  const factory MissingProduct(
      {required final SelectedProductElement product}) = _$MissingProduct;

  factory MissingProduct.fromJson(Map<String, dynamic> json) =
      _$MissingProduct.fromJson;

  SelectedProductElement get product;
  @JsonKey(ignore: true)
  _$$MissingProductCopyWith<_$MissingProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExactProductCopyWith<$Res> {
  factory _$$ExactProductCopyWith(
          _$ExactProduct value, $Res Function(_$ExactProduct) then) =
      __$$ExactProductCopyWithImpl<$Res>;
  @useResult
  $Res call({SelectedProductElement product});

  $SelectedProductElementCopyWith<$Res> get product;
}

/// @nodoc
class __$$ExactProductCopyWithImpl<$Res>
    extends _$SelectedProductListCopyWithImpl<$Res, _$ExactProduct>
    implements _$$ExactProductCopyWith<$Res> {
  __$$ExactProductCopyWithImpl(
      _$ExactProduct _value, $Res Function(_$ExactProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$ExactProduct(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as SelectedProductElement,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SelectedProductElementCopyWith<$Res> get product {
    return $SelectedProductElementCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ExactProduct with DiagnosticableTreeMixin implements ExactProduct {
  const _$ExactProduct({required this.product, final String? $type})
      : $type = $type ?? 'exactProduct';

  factory _$ExactProduct.fromJson(Map<String, dynamic> json) =>
      _$$ExactProductFromJson(json);

  @override
  final SelectedProductElement product;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProductList.exactProduct(product: $product)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProductList.exactProduct'))
      ..add(DiagnosticsProperty('product', product));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExactProduct &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExactProductCopyWith<_$ExactProduct> get copyWith =>
      __$$ExactProductCopyWithImpl<_$ExactProduct>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SelectedProductElement product) similarProduct,
    required TResult Function(SelectedProductElement product) missingProduct,
    required TResult Function(SelectedProductElement product) exactProduct,
    required TResult Function(String label) label,
  }) {
    return exactProduct(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SelectedProductElement product)? similarProduct,
    TResult? Function(SelectedProductElement product)? missingProduct,
    TResult? Function(SelectedProductElement product)? exactProduct,
    TResult? Function(String label)? label,
  }) {
    return exactProduct?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SelectedProductElement product)? similarProduct,
    TResult Function(SelectedProductElement product)? missingProduct,
    TResult Function(SelectedProductElement product)? exactProduct,
    TResult Function(String label)? label,
    required TResult orElse(),
  }) {
    if (exactProduct != null) {
      return exactProduct(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimilarProduct value) similarProduct,
    required TResult Function(MissingProduct value) missingProduct,
    required TResult Function(ExactProduct value) exactProduct,
    required TResult Function(Label value) label,
  }) {
    return exactProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimilarProduct value)? similarProduct,
    TResult? Function(MissingProduct value)? missingProduct,
    TResult? Function(ExactProduct value)? exactProduct,
    TResult? Function(Label value)? label,
  }) {
    return exactProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimilarProduct value)? similarProduct,
    TResult Function(MissingProduct value)? missingProduct,
    TResult Function(ExactProduct value)? exactProduct,
    TResult Function(Label value)? label,
    required TResult orElse(),
  }) {
    if (exactProduct != null) {
      return exactProduct(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExactProductToJson(
      this,
    );
  }
}

abstract class ExactProduct implements SelectedProductList {
  const factory ExactProduct({required final SelectedProductElement product}) =
      _$ExactProduct;

  factory ExactProduct.fromJson(Map<String, dynamic> json) =
      _$ExactProduct.fromJson;

  SelectedProductElement get product;
  @JsonKey(ignore: true)
  _$$ExactProductCopyWith<_$ExactProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LabelCopyWith<$Res> {
  factory _$$LabelCopyWith(_$Label value, $Res Function(_$Label) then) =
      __$$LabelCopyWithImpl<$Res>;
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$$LabelCopyWithImpl<$Res>
    extends _$SelectedProductListCopyWithImpl<$Res, _$Label>
    implements _$$LabelCopyWith<$Res> {
  __$$LabelCopyWithImpl(_$Label _value, $Res Function(_$Label) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_$Label(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Label with DiagnosticableTreeMixin implements Label {
  const _$Label({required this.label, final String? $type})
      : $type = $type ?? 'label';

  factory _$Label.fromJson(Map<String, dynamic> json) => _$$LabelFromJson(json);

  @override
  final String label;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedProductList.label(label: $label)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedProductList.label'))
      ..add(DiagnosticsProperty('label', label));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Label &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelCopyWith<_$Label> get copyWith =>
      __$$LabelCopyWithImpl<_$Label>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SelectedProductElement product) similarProduct,
    required TResult Function(SelectedProductElement product) missingProduct,
    required TResult Function(SelectedProductElement product) exactProduct,
    required TResult Function(String label) label,
  }) {
    return label(this.label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SelectedProductElement product)? similarProduct,
    TResult? Function(SelectedProductElement product)? missingProduct,
    TResult? Function(SelectedProductElement product)? exactProduct,
    TResult? Function(String label)? label,
  }) {
    return label?.call(this.label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SelectedProductElement product)? similarProduct,
    TResult Function(SelectedProductElement product)? missingProduct,
    TResult Function(SelectedProductElement product)? exactProduct,
    TResult Function(String label)? label,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this.label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SimilarProduct value) similarProduct,
    required TResult Function(MissingProduct value) missingProduct,
    required TResult Function(ExactProduct value) exactProduct,
    required TResult Function(Label value) label,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SimilarProduct value)? similarProduct,
    TResult? Function(MissingProduct value)? missingProduct,
    TResult? Function(ExactProduct value)? exactProduct,
    TResult? Function(Label value)? label,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SimilarProduct value)? similarProduct,
    TResult Function(MissingProduct value)? missingProduct,
    TResult Function(ExactProduct value)? exactProduct,
    TResult Function(Label value)? label,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelToJson(
      this,
    );
  }
}

abstract class Label implements SelectedProductList {
  const factory Label({required final String label}) = _$Label;

  factory Label.fromJson(Map<String, dynamic> json) = _$Label.fromJson;

  String get label;
  @JsonKey(ignore: true)
  _$$LabelCopyWith<_$Label> get copyWith => throw _privateConstructorUsedError;
}
