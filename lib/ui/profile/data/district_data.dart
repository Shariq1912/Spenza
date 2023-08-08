import 'package:freezed_annotation/freezed_annotation.dart';

part 'district_data.freezed.dart';
part 'district_data.g.dart';

@freezed
class DistrictData with _$DistrictData{
  const factory DistrictData({
     required String name,

})=_DistrictData;
  factory DistrictData.fromJson(Map<String, dynamic> json) => _$DistrictDataFromJson(json);
}