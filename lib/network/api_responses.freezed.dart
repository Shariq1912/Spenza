// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMsg) error,
    required TResult Function(T data) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMsg)? error,
    TResult? Function(T data)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMsg)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResponseLoading<T> value) loading,
    required TResult Function(_ApiResponseError<T> value) error,
    required TResult Function(_ApiResponseSuccess<T> value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiResponseLoading<T> value)? loading,
    TResult? Function(_ApiResponseError<T> value)? error,
    TResult? Function(_ApiResponseSuccess<T> value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResponseLoading<T> value)? loading,
    TResult Function(_ApiResponseError<T> value)? error,
    TResult Function(_ApiResponseSuccess<T> value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T> value, $Res Function(ApiResponse<T>) then) =
      _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ApiResponseLoadingCopyWith<T, $Res> {
  factory _$$_ApiResponseLoadingCopyWith(_$_ApiResponseLoading<T> value,
          $Res Function(_$_ApiResponseLoading<T>) then) =
      __$$_ApiResponseLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_ApiResponseLoadingCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$_ApiResponseLoading<T>>
    implements _$$_ApiResponseLoadingCopyWith<T, $Res> {
  __$$_ApiResponseLoadingCopyWithImpl(_$_ApiResponseLoading<T> _value,
      $Res Function(_$_ApiResponseLoading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_ApiResponseLoading<T> implements _ApiResponseLoading<T> {
  const _$_ApiResponseLoading();

  @override
  String toString() {
    return 'ApiResponse<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ApiResponseLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMsg) error,
    required TResult Function(T data) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMsg)? error,
    TResult? Function(T data)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMsg)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResponseLoading<T> value) loading,
    required TResult Function(_ApiResponseError<T> value) error,
    required TResult Function(_ApiResponseSuccess<T> value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiResponseLoading<T> value)? loading,
    TResult? Function(_ApiResponseError<T> value)? error,
    TResult? Function(_ApiResponseSuccess<T> value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResponseLoading<T> value)? loading,
    TResult Function(_ApiResponseError<T> value)? error,
    TResult Function(_ApiResponseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ApiResponseLoading<T> implements ApiResponse<T> {
  const factory _ApiResponseLoading() = _$_ApiResponseLoading<T>;
}

/// @nodoc
abstract class _$$_ApiResponseErrorCopyWith<T, $Res> {
  factory _$$_ApiResponseErrorCopyWith(_$_ApiResponseError<T> value,
          $Res Function(_$_ApiResponseError<T>) then) =
      __$$_ApiResponseErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String errorMsg});
}

/// @nodoc
class __$$_ApiResponseErrorCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$_ApiResponseError<T>>
    implements _$$_ApiResponseErrorCopyWith<T, $Res> {
  __$$_ApiResponseErrorCopyWithImpl(_$_ApiResponseError<T> _value,
      $Res Function(_$_ApiResponseError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMsg = null,
  }) {
    return _then(_$_ApiResponseError<T>(
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ApiResponseError<T> implements _ApiResponseError<T> {
  const _$_ApiResponseError({required this.errorMsg});

  @override
  final String errorMsg;

  @override
  String toString() {
    return 'ApiResponse<$T>.error(errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiResponseError<T> &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiResponseErrorCopyWith<T, _$_ApiResponseError<T>> get copyWith =>
      __$$_ApiResponseErrorCopyWithImpl<T, _$_ApiResponseError<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMsg) error,
    required TResult Function(T data) success,
  }) {
    return error(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMsg)? error,
    TResult? Function(T data)? success,
  }) {
    return error?.call(errorMsg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMsg)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMsg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResponseLoading<T> value) loading,
    required TResult Function(_ApiResponseError<T> value) error,
    required TResult Function(_ApiResponseSuccess<T> value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiResponseLoading<T> value)? loading,
    TResult? Function(_ApiResponseError<T> value)? error,
    TResult? Function(_ApiResponseSuccess<T> value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResponseLoading<T> value)? loading,
    TResult Function(_ApiResponseError<T> value)? error,
    TResult Function(_ApiResponseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ApiResponseError<T> implements ApiResponse<T> {
  const factory _ApiResponseError({required final String errorMsg}) =
      _$_ApiResponseError<T>;

  String get errorMsg;
  @JsonKey(ignore: true)
  _$$_ApiResponseErrorCopyWith<T, _$_ApiResponseError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ApiResponseSuccessCopyWith<T, $Res> {
  factory _$$_ApiResponseSuccessCopyWith(_$_ApiResponseSuccess<T> value,
          $Res Function(_$_ApiResponseSuccess<T>) then) =
      __$$_ApiResponseSuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_ApiResponseSuccessCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$_ApiResponseSuccess<T>>
    implements _$$_ApiResponseSuccessCopyWith<T, $Res> {
  __$$_ApiResponseSuccessCopyWithImpl(_$_ApiResponseSuccess<T> _value,
      $Res Function(_$_ApiResponseSuccess<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ApiResponseSuccess<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_ApiResponseSuccess<T> implements _ApiResponseSuccess<T> {
  const _$_ApiResponseSuccess({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiResponseSuccess<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiResponseSuccessCopyWith<T, _$_ApiResponseSuccess<T>> get copyWith =>
      __$$_ApiResponseSuccessCopyWithImpl<T, _$_ApiResponseSuccess<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMsg) error,
    required TResult Function(T data) success,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMsg)? error,
    TResult? Function(T data)? success,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMsg)? error,
    TResult Function(T data)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ApiResponseLoading<T> value) loading,
    required TResult Function(_ApiResponseError<T> value) error,
    required TResult Function(_ApiResponseSuccess<T> value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ApiResponseLoading<T> value)? loading,
    TResult? Function(_ApiResponseError<T> value)? error,
    TResult? Function(_ApiResponseSuccess<T> value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ApiResponseLoading<T> value)? loading,
    TResult Function(_ApiResponseError<T> value)? error,
    TResult Function(_ApiResponseSuccess<T> value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ApiResponseSuccess<T> implements ApiResponse<T> {
  const factory _ApiResponseSuccess({required final T data}) =
      _$_ApiResponseSuccess<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$_ApiResponseSuccessCopyWith<T, _$_ApiResponseSuccess<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
