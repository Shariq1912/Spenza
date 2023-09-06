// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchProductResponse _$$_SearchProductResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SearchProductResponse(
      departmentName: json['department_name'] as String,
      isExist: json['is_exist'] as bool,
      genericNames: (json['genericNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      unit: json['unit'] as String? ?? "",
      site: json['site'] as String? ?? "",
      measure: json['measure'] as String,
      price: (json['price'] as num).toDouble(),
      productId: json['product_id'] as String,
      name: json['name'] as String,
      productRef: json['productRef'] as String,
      brand: json['brand'] as String,
      pImage: json['pImage'] as String,
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$_SearchProductResponseToJson(
        _$_SearchProductResponse instance) =>
    <String, dynamic>{
      'department_name': instance.departmentName,
      'is_exist': instance.isExist,
      'genericNames': instance.genericNames,
      'unit': instance.unit,
      'site': instance.site,
      'measure': instance.measure,
      'price': instance.price,
      'product_id': instance.productId,
      'name': instance.name,
      'productRef': instance.productRef,
      'brand': instance.brand,
      'pImage': instance.pImage,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };
