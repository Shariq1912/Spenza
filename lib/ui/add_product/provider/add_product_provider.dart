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
    // Fetch all generic names and department names in one batch
    Map<String, DocumentSnapshot> genericNamesMap = {};

    QuerySnapshot genericNamesSnapshot =
        await FirebaseFirestore.instance.collection('genericName').get();
    genericNamesMap = Map.fromEntries(
      genericNamesSnapshot.docs.map((doc) => MapEntry(doc.id, doc)),
    );

    QuerySnapshot departmentsSnapshot =
        await FirebaseFirestore.instance.collection('departments').get();
    // Convert the departmentsSnapshot to a Map<String, String>

    Map<String, String> departmentsMap = Map.fromEntries(
        departmentsSnapshot.docs.map((doc) => MapEntry(
            doc.id, (doc.data() as Map<String, dynamic>)['name'].toString())));

    QuerySnapshot storesSnapshot =
        await FirebaseFirestore.instance.collection('stores').get();

    Map<String, Map<String, dynamic>> storesMap = Map.fromEntries(
      storesSnapshot.docs
          .map((doc) => MapEntry(doc.id, doc.data() as Map<String, dynamic>)),
    );

    // print('Generic Names Map: $genericNamesMap');
    // print('Departments Map: $departmentsMap');

    // Get all documents from the 'products_clone' collection
    QuerySnapshot cloneQuerySnapshot =
        await FirebaseFirestore.instance.collection('products_clone').get();

    // Create a set to store the existing 'idStore' values from the 'products_clone' collection
    Set<String> existingIdStores =
        Set<String>.from(cloneQuerySnapshot.docs.map((doc) => doc.id));
    // print(existingIdStores.toString());

    // Query the 'products' collection and filter out the documents with matching 'idStore'
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        // .where('idStore', whereNotIn: existingIdStores.toList())
        .limit(3)
        .get();

    Set<String> trackedIdStores = {};

    // Create a new 'products_clone' collection
    CollectionReference productsCloneRef =
        FirebaseFirestore.instance.collection('products_clone');

    // Create a WriteBatch to perform batched writes
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Loop through each document
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      // Get the idStore from the original document
      String idStore = documentSnapshot['idStore'];

      DocumentReference newProductDocRef = productsCloneRef.doc(idStore);

      if (!trackedIdStores.contains(idStore)) {
        String genericName = "";
        for (DocumentReference genericNameRef
            in documentSnapshot['genericNameRef']) {
          DocumentSnapshot genericNameSnapshot = await genericNameRef.get();
          print("generic name before  = ${genericNameSnapshot.id}");

          // Check if the generic name exists in the map
          if (genericNamesMap.containsKey(genericNameSnapshot.id)) {
            // Access the 'genericName' field from the data of the DocumentSnapshot
            Map<String, dynamic>? data = genericNamesMap[genericNameSnapshot.id]
                ?.data() as Map<String, dynamic>?;
            genericName = data?['genericName'];
          } else {
            print(
                'Generic Name not found in the genericNamesMap for ID: ${genericNameSnapshot.id}');
          }
        }

        DocumentReference departmentRef = documentSnapshot['departmentRef'];

        trackedIdStores.add(idStore);
        // Add the 'set' operation to the batch for the new document
        batch.set(newProductDocRef, {
          'idStore': idStore,
          // Set the document ID as the idStore
          'is_exist': documentSnapshot['Existence'],
          'department': documentSnapshot['department'],
          'departmentRef': documentSnapshot['departmentRef'],
          'genericNameRef': documentSnapshot['genericNameRef'],
          'measure': documentSnapshot['measure'],
          'name': documentSnapshot['name'],
          'pImage': documentSnapshot['pImage'],
          'genericNames': [genericName],
          'departments': [departmentsMap[departmentRef.id]],
          // Add the 'departmentRef' data as an array
        });
      }

      // Create a new 'prices' subcollection for the new document
      CollectionReference pricesRef = newProductDocRef.collection('prices');
      DocumentReference storeRef = documentSnapshot['bstoreRef'];

      // Get the 'storeRef' from the original document and fetch the store data
      /*DocumentSnapshot storeSnapshot =
          storesMap[documentSnapshot['bstoreRef']]!;

      print("stores names = ${storeSnapshot['name'].toString()}");*/

      // Add the 'set' operation to the batch for the 'prices' subcollection document
      batch.set(pricesRef.doc(), {
        'price': documentSnapshot['bPrice'] ?? 0,
        'storeName': storesMap[storeRef.id]?['name'] ?? "Cool Store",
        'logo': storesMap[storeRef.id]?['logo'] ?? "Cool Logo",
        // 'storeName': "Cool Store",
        // 'logo': "Cool Logo",
      });
    }

    // Commit the batch to perform the batched writes
    await batch.commit();

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
