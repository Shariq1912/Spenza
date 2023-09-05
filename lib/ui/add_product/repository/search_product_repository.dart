import 'package:dio/dio.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/data/search_product_response.dart';

class SearchProductRepository {
  final Dio client;

  SearchProductRepository({required this.client});


  Future<List<Product>> searchProductRepository({
    required List<String> storeIds,
    required String query,
    required CancelToken cancelToken,
  }) async {
    try {
      final response = await client.post("searchProducts", data: {
        "store_ids": storeIds,
        "query": query,
      },cancelToken: cancelToken);

      if (response.statusCode == 200) {
        final List<dynamic> responseDataList = response.data;

        // Deserialize the list of ProductModel
        final List<SearchProductResponse> searchProducts = responseDataList
            .map((jsonData) => SearchProductResponse.fromJson(
                jsonData as Map<String, dynamic>))
            .toList();

        print("PRODUCTS FROM DIO Before== ${searchProducts.toString()}");

        final products =
            searchProducts.map((e) => Product.fromSearchResponse(e)).toList();


        print("PRODUCTS FROM DIO == ${products.toString()}");

        return products;
      }
      throw Exception("Something went wrong!");
    } catch (e) {
      print("catch from dio == $e");
      rethrow;
    }
  }
}
