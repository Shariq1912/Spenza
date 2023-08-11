import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_pick_state.freezed.dart';


@freezed
class ImagePickState with _$ImagePickState {
  const factory ImagePickState() = _Initial;
  const factory ImagePickState.selected(File selectedImage) = _Selected;
  const factory ImagePickState.uploaded({required String msg}) = _Uploaded;
  const factory ImagePickState.error({required String msg}) = _Error;
}