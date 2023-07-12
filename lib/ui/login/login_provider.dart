import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/login/login_repository.dart';

/*
final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(),
);
*/

/*
final loginProvider = StateNotifierProvider<LoginRepository, ApiResponse>(
      (ref) => LoginRepository(client: ref.watch(dioProvider)),
);
*/



final loginRepositoryProvider = StateNotifierProvider<LoginRepository, ApiResponse>((ref) {
  return LoginRepository();
});
