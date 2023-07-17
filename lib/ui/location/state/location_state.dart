import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState() = _Initial;

  const factory LocationState.loading() = _Loading;

  const factory LocationState.success({required String message}) = _Success;

  const factory LocationState.error({required String message}) = _Error;

  const factory LocationState.denied() = _PermissionDenied;
}
