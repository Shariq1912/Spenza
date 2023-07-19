import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/my_store/widget/my_store_repository.dart';

final allStoreProvider = StateNotifierProvider<MyStoreRepository,ApiResponse >((ref){
  return MyStoreRepository();
} );