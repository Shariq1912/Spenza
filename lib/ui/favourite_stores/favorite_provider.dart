import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/favourite_stores/favorite_repository.dart';
import 'package:spenza/ui/login/login_repository.dart';


final favoriteProvider = StateNotifierProvider<FavoriteRepository, ApiResponse>((ref) {
  return FavoriteRepository();
});
