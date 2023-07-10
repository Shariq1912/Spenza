import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_login_state.freezed.dart';

@freezed
class GoogleLoginState with _$GoogleLoginState {
  const factory GoogleLoginState.loading() = GoogleLoginLoading;
  const factory GoogleLoginState.authenticated({String? email, String? displayName}) = GoogleLoginAuthenticated;
  const factory GoogleLoginState.unauthenticated() = GooleLoginUnAuthenticated;
  const factory GoogleLoginState.authError({String? errorMessage}) = GoogleLoginAuthError;
}
