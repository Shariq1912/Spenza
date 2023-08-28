import 'package:freezed_annotation/freezed_annotation.dart';

part 'zipcode_model.freezed.dart';
part 'zipcode_model.g.dart';

@freezed
class ZipcodeModel with _$ZipcodeModel{
  const factory ZipcodeModel({
    required int zipcode,
})= _ZipcodeModel;
  factory ZipcodeModel.fromJson(Map<String, dynamic> json) => _$ZipcodeModelFromJson(json);
}