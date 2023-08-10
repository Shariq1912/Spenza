// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SelectedProduct _$$_SelectedProductFromJson(Map<String, dynamic> json) =>
    _$_SelectedProduct(
      storeRef:
          const DocumentReferenceJsonConverter().fromJson(json['storeRef']),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) =>
                  SelectedProductList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_SelectedProductToJson(_$_SelectedProduct instance) =>
    <String, dynamic>{
      'storeRef':
          const DocumentReferenceJsonConverter().toJson(instance.storeRef),
      'total': instance.total,
      'products': instance.products,
    };
