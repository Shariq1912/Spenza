import 'package:freezed_annotation/freezed_annotation.dart';

part 'departments_data.freezed.dart';
part 'departments_data.g.dart';

@freezed
class DepartmentDataClass with _$DepartmentDataClass {
  const factory DepartmentDataClass({
      required String name,
      String? documentId,
}) =_DepartmentDataClass;

  factory DepartmentDataClass.fromJson(Map<String, dynamic> json) => _$DepartmentDataClassFromJson(json);
}