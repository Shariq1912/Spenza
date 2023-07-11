import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../network/api_responses.dart';
import '../../repository/google_repository.dart';
import 'google_login_state.dart';

part 'google_login_event.dart';
class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final GoogleLoginRepository authRepository;

  GoogleLoginBloc({required this.authRepository})
      : super(const GoogleLoginInitial()) {
    on<GoogleSignInRequested>(_mapGoogleSignInRequestedToState);
  }

  Future<void> _mapGoogleSignInRequestedToState(
      GoogleSignInRequested event, Emitter<GoogleLoginState> emit) async {
    emit(const GoogleLoginLoading());

    try {
      final ApiResponse<UserCredential> response =
      await authRepository.signInWithGoogle();
      final userData = await GoogleSignIn().signIn();
      String email = userData!.email;
      String? displayName = userData!.displayName;

      response.when(
        loading: () {},
        error: (errorMsg) {
          emit(GoogleLoginAuthError(errorMessage: errorMsg));
          emit(const GooleLoginUnAuthenticated());
        },
        success: (userData) {
          emit(GoogleLoginState.authenticated(
              email: email, displayName: displayName));
        },
      );
    } catch (e) {
      emit(GoogleLoginAuthError(errorMessage: e.toString()));
      emit(const GooleLoginUnAuthenticated());
    }
  }
}

