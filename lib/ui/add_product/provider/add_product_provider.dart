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

  Future<void> cloneProductsCollection() async {
    // Get all documents from the 'products' collection
    /*QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();*/

    // Create a new 'products_clone' collection
    CollectionReference productsCloneRef =
        FirebaseFirestore.instance.collection('products_clone');

    QuerySnapshot cloneQuerySnapshot =
        await FirebaseFirestore.instance.collection('products_clone').get();

    // Create a set to store the existing 'idStore' values from the 'products_clone' collection
    Set<String> existingIdStores =
        Set<String>.from(cloneQuerySnapshot.docs.map((doc) => doc.id));

    print(existingIdStores.toString());

    // Query the 'products' collection and filter out the documents with matching 'idStore'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('idStore', whereNotIn: existingIdStores.toList())
        .get();


    // Loop through each document
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {

      // Get the idStore from the original document
      String idStore = documentSnapshot['idStore'];

      // Fetch the 'genericNameRef' document
      DocumentSnapshot genericNameSnapshot =
          await documentSnapshot['genericNameRef'].get();

      // Fetch the 'departmentRef' document
      DocumentSnapshot departmentSnapshot =
          await documentSnapshot['departmentRef'].get();

      // Create a new document in the 'products_clone' collection with idStore as the document ID
      DocumentReference newProductDocRef = productsCloneRef.doc(idStore);

      // Set the data from the original document
      await newProductDocRef.set({
        'idStore': idStore,
        // Set the document ID as the idStore
        'is_exist': documentSnapshot['Existence'],
        'department': documentSnapshot['department'],
        'departmentRef': documentSnapshot['departmentRef'],
        'genericNameRef': documentSnapshot['genericNameRef'],
        'measure': documentSnapshot['measure'],
        'name': documentSnapshot['name'],
        'pImage': documentSnapshot['pImage'],
        'genericNames': [genericNameSnapshot.data()],
        // Add the 'genericNameRef' data as an array
        'departments': [departmentSnapshot.data()],
        // Add the 'departmentRef' data as an array
      });

      // Create a new 'prices' subcollection for the new document
      CollectionReference pricesRef = newProductDocRef.collection('prices');
      // Get the 'storeRef' from the original document and fetch the store data
      DocumentSnapshot storeSnapshot = await documentSnapshot['bstoreRef'].get();


      // Get the bPrice from the original document and add it to the 'prices' subcollection
      await pricesRef.add({
        'price': documentSnapshot['bPrice'] ?? 0,
        'storeName': storeSnapshot['name'] ?? "Cool Store",
        'logo': storeSnapshot['logo'] ?? "Cool Logo",
      });
    }

    print('Products collection cloned successfully!');
  }

  Future<void> searchProducts2(
      {String query = "Achiote La Anita 100 g"}) async {
    Future.delayed(Duration.zero);

    List<Map<String, dynamic>> searchResults = [];

    /// We can do first search on name field if empty then department and if empty then genericNameRef

    try {
      state = AsyncValue.loading();

      // Query the Firestore database for products that match the search query and have Existence as true

      QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection('products')
          .where('Existence', isEqualTo: true)
          .where('name', isGreaterThanOrEqualTo: "Achiote")
          .where('name', isLessThanOrEqualTo: "Achiote" + '\uf8ff')
          // .where('name', arrayContains: "Achiote")
          .get();

      // Add the search results to the list
      searchResults = snapshot.docs.map((doc) => doc.data()).toList();
      state = AsyncValue.data(searchResults);
    } catch (e) {
      print('Error searching products: $e');
      state =
          AsyncValue.error('Error searching products: $e', StackTrace.current);
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

  Future<void> searchProducts({String query = ""}) async {
    // List to store search results
    List<Map<String, dynamic>> searchResults = [];

    try {
      state = AsyncValue.loading();

      // Create a single query with multiple arrayContains conditions
      final query = _fireStore
          .collection('products')
          .where('Existence', isEqualTo: true)
          .where(
            'name',
            arrayContains: "Achiote",
          )
          .where(
            'department',
            arrayContains: "Achiote",
          )
          .where(
            'genericNameRef',
            arrayContains: "Achiote",
          );

      // Perform the query and collect the results
      final results = await query.get();

      // Merge the results into a single list
      searchResults.addAll(results.docs.map((doc) => doc.data()));

      state = AsyncValue.data(searchResults);
    } catch (e) {
      print('Error searching products: $e');
      state =
          AsyncValue.error('Error searching products: $e', StackTrace.current);
    }
  }
}
