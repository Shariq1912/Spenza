import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_list_model.freezed.dart';

part 'my_list_model.g.dart';

@freezed
class MyListModel with _$MyListModel {
  const factory MyListModel({
    required String description,
    required String name,
    required String uid,
    required String usersRef,
    String? myListPhoto,
    @Default(null) String? documentId,
     String? path,
     String? count,
  }) = _MyListModel;

  factory MyListModel.fromJson(Map<String, dynamic> json) =>
      _$MyListModelFromJson(json);
}
