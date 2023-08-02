import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spenza/utils/document_reference_converter.dart';

part 'user_product_insert.freezed.dart';

part 'user_product_insert.g.dart';

@freezed
class UserProductInsert with _$UserProductInsert {
  @DocumentReferenceJsonConverter()
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
    includeIfNull: false,
  )
  const factory UserProductInsert({
    DocumentReference? productId,
    @Default(1) int quantity,
  }) = _UserProductInsert;

  factory UserProductInsert.fromJson(Map<String, dynamic> json) =>
      _$UserProductInsertFromJson(json);
}
