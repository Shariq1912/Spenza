// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_pick_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImagePickState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagePickStateCopyWith<$Res> {
  factory $ImagePickStateCopyWith(
          ImagePickState value, $Res Function(ImagePickState) then) =
      _$ImagePickStateCopyWithImpl<$Res, ImagePickState>;
}

/// @nodoc
class _$ImagePickStateCopyWithImpl<$Res, $Val extends ImagePickState>
    implements $ImagePickStateCopyWith<$Res> {
  _$ImagePickStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ImagePickStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ImagePickState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) {
    return $default?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ImagePickState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_SelectedCopyWith<$Res> {
  factory _$$_SelectedCopyWith(
          _$_Selected value, $Res Function(_$_Selected) then) =
      __$$_SelectedCopyWithImpl<$Res>;
  @useResult
  $Res call({File selectedImage});
}

/// @nodoc
class __$$_SelectedCopyWithImpl<$Res>
    extends _$ImagePickStateCopyWithImpl<$Res, _$_Selected>
    implements _$$_SelectedCopyWith<$Res> {
  __$$_SelectedCopyWithImpl(
      _$_Selected _value, $Res Function(_$_Selected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedImage = null,
  }) {
    return _then(_$_Selected(
      null == selectedImage
          ? _value.selectedImage
          : selectedImage // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$_Selected implements _Selected {
  const _$_Selected(this.selectedImage);

  @override
  final File selectedImage;

  @override
  String toString() {
    return 'ImagePickState.selected(selectedImage: $selectedImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Selected &&
            (identical(other.selectedImage, selectedImage) ||
                other.selectedImage == selectedImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      __$$_SelectedCopyWithImpl<_$_Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) {
    return selected(selectedImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) {
    return selected?.call(selectedImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(selectedImage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) {
    return selected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) {
    return selected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(this);
    }
    return orElse();
  }
}

abstract class _Selected implements ImagePickState {
  const factory _Selected(final File selectedImage) = _$_Selected;

  File get selectedImage;
  @JsonKey(ignore: true)
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$ImagePickStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'ImagePickState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ImagePickState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_UploadedCopyWith<$Res> {
  factory _$$_UploadedCopyWith(
          _$_Uploaded value, $Res Function(_$_Uploaded) then) =
      __$$_UploadedCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_UploadedCopyWithImpl<$Res>
    extends _$ImagePickStateCopyWithImpl<$Res, _$_Uploaded>
    implements _$$_UploadedCopyWith<$Res> {
  __$$_UploadedCopyWithImpl(
      _$_Uploaded _value, $Res Function(_$_Uploaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_Uploaded(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Uploaded implements _Uploaded {
  const _$_Uploaded({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'ImagePickState.uploaded(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Uploaded &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadedCopyWith<_$_Uploaded> get copyWith =>
      __$$_UploadedCopyWithImpl<_$_Uploaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) {
    return uploaded(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) {
    return uploaded?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (uploaded != null) {
      return uploaded(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) {
    return uploaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) {
    return uploaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (uploaded != null) {
      return uploaded(this);
    }
    return orElse();
  }
}

abstract class _Uploaded implements ImagePickState {
  const factory _Uploaded({required final String msg}) = _$_Uploaded;

  String get msg;
  @JsonKey(ignore: true)
  _$$_UploadedCopyWith<_$_Uploaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$ImagePickStateCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_Error(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'ImagePickState.error(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(File selectedImage) selected,
    required TResult Function() loading,
    required TResult Function(String msg) uploaded,
    required TResult Function(String msg) error,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(File selectedImage)? selected,
    TResult? Function()? loading,
    TResult? Function(String msg)? uploaded,
    TResult? Function(String msg)? error,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(File selectedImage)? selected,
    TResult Function()? loading,
    TResult Function(String msg)? uploaded,
    TResult Function(String msg)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(_Selected value) selected,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Uploaded value) uploaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(_Selected value)? selected,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Uploaded value)? uploaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(_Selected value)? selected,
    TResult Function(_Loading value)? loading,
    TResult Function(_Uploaded value)? uploaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ImagePickState {
  const factory _Error({required final String msg}) = _$_Error;

  String get msg;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}
