// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_product_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProductInsert _$$_UserProductInsertFromJson(Map<String, dynamic> json) =>
    _$_UserProductInsert(
      productRef:
          const DocumentReferenceJsonConverter().fromJson(json['product_ref']),
      productId: json['product_id'] as String,
      quantity: json['quantity'] as int? ?? 1,
    );

Map<String, dynamic> _$$_UserProductInsertToJson(
    _$_UserProductInsert instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('product_ref',
      const DocumentReferenceJsonConverter().toJson(instance.productRef));
  val['product_id'] = instance.productId;
  val['quantity'] = instance.quantity;
  return val;
}
