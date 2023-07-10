import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_responses.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T>{
  const factory ApiResponse.loading() = _ApiResponseLoading<T>;
  const factory ApiResponse.error({required String errorMsg}) = _ApiResponseError<T>;
  const factory ApiResponse.success({required T data}) = _ApiResponseSuccess<T>;
}