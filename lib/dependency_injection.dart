import 'package:get_it/get_it.dart';
import 'package:spenza/bloc/google_login/google_login_bloc.dart';
import 'package:spenza/repository/google_repository.dart';

final getIt = GetIt.instance;

inject() async {
  await _registerSingleton();
  _registerBlocs();

}

_registerSingleton() async {
  _registerRepositories();
}

void _registerRepositories() {
  getIt.registerSingleton(GoogleLoginRepository());
}

void _registerBlocs() {
  getIt.registerFactory(() => GoogleLoginBloc(authRepository: getIt()));
}