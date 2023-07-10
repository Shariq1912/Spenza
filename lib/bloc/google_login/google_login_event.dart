part of 'google_login_bloc.dart';

@immutable
abstract class GoogleLoginEvent {}
class GoogleSignInRequested extends GoogleLoginEvent {}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends GoogleLoginEvent {}