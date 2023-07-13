import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/sign_up/register_repository.dart';

final registerRepositoryProvider = StateNotifierProvider<RegisterRepository, ApiResponse>((ref) {
  return RegisterRepository();
});