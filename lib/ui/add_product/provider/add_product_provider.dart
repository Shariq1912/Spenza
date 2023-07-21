import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_provider.g.dart';

@riverpod
class AddProduct extends _$AddProduct {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> build() async {
    return [];
  }

  Future<void> searchProducts({String query = "Achiote"}) async {
    Future.delayed(Duration.zero);

    List<Map<String, dynamic>> searchResults = [];

    /// We can do first search on name field if empty then department and if empty then genericNameRef

    try {
      state = AsyncValue.loading();

      // Query the Firestore database for products that match the search query and have Existence as true

      QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('products')
          .where('Existence', isEqualTo: true)
          .where('name', isEqualTo: query)
          .get();

      // Add the search results to the list
      searchResults = snapshot.docs.map((doc) => doc.data()).toList();
      state = AsyncValue.data(searchResults);
    } catch (e) {
      print('Error searching products: $e');
      state = AsyncValue.error('Error searching products: $e', StackTrace.current);
    }
  }

/*Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    List<Map<String, dynamic>> searchResults = [];

    // Split the user's query into individual search terms
    List<String> searchTerms = query.trim().toLowerCase().split(" ");

    try {
      // Perform separate queries for each search term
      List<QuerySnapshot<Map<String, dynamic>>> querySnapshots = await Future.wait(
        searchTerms.map((term) {
          return FirebaseFirestore.instance
              .collection('products')
              .where('genericNames', arrayContains: term)
              .where('department', isEqualTo: term)
              .where('name', isEqualTo: term)
              .where('Existence', isEqualTo: true)
              .get();
        }),
      );

      // Merge and rank the search results based on relevance
      searchResults = querySnapshots
          .expand((snapshot) => snapshot.docs.map((doc) => doc.data()))
          .toSet() // Remove duplicates
          .toList();

      // Sort the results based on relevance (you can implement your own ranking logic)
      // For example, you might consider using a scoring system based on the number of matched terms.

    } catch (e) {
      print('Error searching products: $e');
    }

    return searchResults;
  }*/
}
