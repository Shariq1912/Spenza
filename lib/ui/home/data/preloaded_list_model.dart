import 'package:freezed_annotation/freezed_annotation.dart';

part 'preloaded_list_model.freezed.dart';

part 'preloaded_list_model.g.dart';

@freezed
class PreloadedListModel with _$PreloadedListModel {
  const factory PreloadedListModel({
    required String id,
    required String name,
    @JsonKey(name: "preloaded_photo") required String preloadedPhoto,
    required String description,
    required String path,
  }) = _PreloadedListModel;

  factory PreloadedListModel.fromJson(Map<String, dynamic> json) =>
      _$PreloadedListModelFromJson(json);
}
