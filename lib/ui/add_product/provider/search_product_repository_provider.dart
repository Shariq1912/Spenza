import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/network/dio_client.dart';
import 'package:spenza/ui/add_product/repository/search_product_repository.dart';

part 'search_product_repository_provider.g.dart';

@riverpod
SearchProductRepository searchProductRepository(SearchProductRepositoryRef ref) =>
    SearchProductRepository(
      client: ref.watch(dioProvider), // the provider we defined above
    );
