import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_model.freezed.dart';
part 'receipt_model.g.dart';

@freezed
class ReceiptModel with _$ReceiptModel{
  const factory ReceiptModel({
    required String uid,
     String? name,
     String? receipt,
     String? description,
    String? date,
})=_ReceiptModel;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => _$ReceiptModelFromJson(json);
}