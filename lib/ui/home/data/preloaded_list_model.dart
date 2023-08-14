import 'package:freezed_annotation/freezed_annotation.dart';

part 'preloaded_list_model.freezed.dart';
part 'preloaded_list_model.g.dart';

@freezed
class PreloadedListModel with _$PreloadedListModel{
  const factory PreloadedListModel({
    required String name,
    required String preloaded_photo,

})= _PreloadedListModel;

  factory PreloadedListModel.fromJson(Map<String,dynamic> json) => _$PreloadedListModelFromJson(json);
}