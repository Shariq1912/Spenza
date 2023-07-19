import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_store_state.dart';
import 'package:spenza/ui/favourite_stores/favorite_repository.dart';
import 'package:spenza/ui/login/login_repository.dart';

import '../location/location_provider.dart';


/*
final favoriteProvider = StateNotifierProvider<FavoriteRepository, FavouriteStoreState>((ref) {
  return FavoriteRepository();
});
*/

