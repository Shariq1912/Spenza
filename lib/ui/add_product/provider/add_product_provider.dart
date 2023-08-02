import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/add_product/data/user_product_insert.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'add_product_provider.g.dart';

@riverpod
class AddProduct extends _$AddProduct {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> build() async {
    return [];
  }


  Future<void> collectionGroupViaStoreRef() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Replace 'storeRef' with the actual name of the field that holds the store reference in the 'products' subcollection
      final String storeRefString = "stores_clone/Vdw4xZvVjdIT8YQ1W6Y8";
      final DocumentReference storeRef = firestore.doc(storeRefString);

      final querySnapshot = await firestore
          .collectionGroup('product')
          .where('storeRef', isEqualTo: storeRef)
          .get();

      // Process the querySnapshot to get the product documents
      final List products =
          querySnapshot.docs.map((doc) => doc['departments']).toList();

      // Now you have the list of products belonging to the specified storeRef
      print(products);
    } catch (e) {
      print('Error fetching products: $e');
    }
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

    Set<String> trackedIdStores = {};

    // Create a new 'products_clone' collection
    CollectionReference productsCloneRef =
        FirebaseFirestore.instance.collection('products_clone_new');

    var counter = 0;
    while (counter < 50) {
      // Create a WriteBatch to perform batched writes
      WriteBatch batch = FirebaseFirestore.instance.batch();
      // Query the 'products' collection and filter out the documents with matching 'idStore'
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')

          /// need to add start after else it will create duplicate values.
          // .where('idStore', whereNotIn: existingIdStores.toList())
          .limit(10)
          .get();

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
              Map<String, dynamic>? data =
                  genericNamesMap[genericNameSnapshot.id]?.data()
                      as Map<String, dynamic>?;
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
          'storeRef': documentSnapshot['bstoreRef'] ?? "Cool Store",
          'store_location':
              storesMap[storeRef.id]?['location'] ?? "Cool Location",
          // 'storeName': "Cool Store",
          // 'logo': "Cool Logo",
        });
      }

      // Commit the batch to perform the batched writes
      await batch.commit();

      print('Products collection cloned successfully!');
      counter++;
      Future.delayed(Duration(seconds: 3));
    }
  }

  Future<void> fakePricesForTesting() async {
    String fakeId = "1238800330Walmart";
    String fromId = "1238800248Walmart"; // Jagon Id
    String ketchUpId = "1300000124Walmart";
    String jagonId = "1238800248Walmart";
    String detergentId = "1238800330Walmart";

    try {
      // Get the reference to the 'prices' subcollection under the 'products' collection for the given 'fromId'
      /*CollectionReference pricesRef = FirebaseFirestore.instance
          .collection('products_clone')
          .doc(fromId)
          .collection('prices');


      CollectionReference pricesRef2 = FirebaseFirestore.instance
          .collection('products_clone')
          .doc(fakeId)
          .collection('prices');

      // Query the 'prices' subcollection and fetch all the documents
      QuerySnapshot pricesSnapshot = await pricesRef.get();

      // Loop through the documents in the 'prices' subcollection
      for (QueryDocumentSnapshot priceDoc in pricesSnapshot.docs) {
        pricesRef2.add({
          "logo": priceDoc['logo'],
          "storeName": priceDoc['storeName'],
          "storeRef": priceDoc['storeRef'],
          "price": priceDoc['price'], // add random number here
        });
      }*/

      QuerySnapshot query = await _fireStore
          .collection('products_clone')
          .where('idStore', whereIn: [ketchUpId, detergentId, jagonId]).get();

      for (QueryDocumentSnapshot snapshot in query.docs) {
        CollectionReference pricesRef = _fireStore
            .collection('products_clone')
            .doc(snapshot.id)
            .collection('prices');

        QuerySnapshot pricesSnapshot = await pricesRef.get();

        for (QueryDocumentSnapshot priceDoc in pricesSnapshot.docs) {
          pricesRef.doc(priceDoc.id).update({
            "is_exist": true,
          });
        }
      }
    } catch (e) {
      print('Error fetching prices: $e');
    }
  }

  Future<void> searchProducts({String query = "Tomate"}) async {
    Future.delayed(Duration.zero);

    // Available Products
    // Papel Aluminio Reynolds Wrap 20 m,
    // Jabon de tocador Lirio dermatologico 5 pzas de 120 g c/u,
    // Detergente liquido Bold 3 carinitos de mama 4.23 l
    // Ketchup Heinz 397 g

    // Soriana City Center = 20.68016662, -103.3822084

    List<Product> searchResults = [];
    List<DocumentReference> nearbyStoreRefs = [];

    final nearbyStores = await _getNearbyStores(
      userLocation: GeoPoint(20.68016662, -103.3822084),
    );

    nearbyStores.forEach(
      (element) => nearbyStoreRefs.add(
        _fireStore.collection('stores').doc(element.id),
      ),
    );

    try {
      state = AsyncValue.loading();
      query = query.isEmpty ? "Tomate" : query.toLowerCase();

      // todo query is case sensitive, regex not possible on firestore field
      QuerySnapshot snapshot = await _fireStore
          .collection('products_mvp')
          .where('storeRef', whereIn: nearbyStoreRefs)
          .where('is_exist', isEqualTo: true)
          .get();

      for (var value in snapshot.docs) {
        final genericNames = (value['genericNames'] as List<dynamic> ?? [])
            .map((name) => name.toString().toLowerCase())
            .toSet()
            .toList();

        final Product product = Product(
          productId: value.id,
          isExist: value['is_exist'],
          department: value['department_name'],
          departments: [value['department_name']],
          measure: value['measure'] == "kg" ? "1 kg" : value['measure'],
          storeRef: value['storeRef'].id.toString(),
          name: value['name'],
          pImage: value['pImage'],
          genericNames: genericNames,
          minPrice: value['price'].toString(),
          maxPrice:
              "${value['storeRef'].id.toString()} - ${genericNames.toString()}",
        );

        var hasGenericNameMatched = product.genericNames.any((genericName) =>
            genericName.toLowerCase().contains(query.toLowerCase()));

        if (hasGenericNameMatched ||
            product.name.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }

      /*searchResults.forEach(
        (element) => print(
          "ID : ${element.productId} == Product Name : ${element.name} == Store : ${element.storeRef} == Department Name : ${element.department} == Price : ${element.minPrice} == GenericNames : ${element.genericNames.toString()}",
        ),
      );*/

      final List<Product> filteredList = [];

      /// Works only if list sorted by product whose genericNames similar
      if (searchResults.isNotEmpty) {
        Product selectedProduct = searchResults.first;
        double minPrice = double.parse(selectedProduct.minPrice);
        double maxPrice = double.parse(selectedProduct.minPrice);

        for (var i = 1; i < searchResults.length; i++) {
          Product product = searchResults[i];

          bool isSimilarProduct = selectedProduct.measure == product.measure &&
              selectedProduct.department == product.department &&
              selectedProduct.genericNames
                  .toSet()
                  .containsAll(product.genericNames.toSet());

          if (isSimilarProduct) {
            double productMinPrice = double.parse(product.minPrice);
            minPrice = min(minPrice, productMinPrice);
            maxPrice = max(maxPrice, productMinPrice);
          } else {
            Product filteredProduct = selectedProduct.copyWith(
              minPrice: minPrice.toString(),
              maxPrice: maxPrice.toString(),
            );
            filteredList.add(filteredProduct);

            /// Reset selected Product to the current loop element and same for min and max price
            selectedProduct = product;
            minPrice = double.parse(product.minPrice);
            maxPrice = double.parse(product.minPrice);
          }
        }
        /// Last selected product will not be able to added list due to loop ended so handled outside
        Product filteredProduct = selectedProduct.copyWith(
          minPrice: minPrice.toString(),
          maxPrice: maxPrice.toString(),
        );
        filteredList.add(filteredProduct);
      }

      print('Filter List: ${filteredList.toString()}');

      state = AsyncValue.data(filteredList);
    } catch (e) {
      print('Error searching products: $e');
      state =
          AsyncValue.error('Error searching products: $e', StackTrace.current);
    }
  }

  Future<List<Stores>> _getNearbyStores({required var userLocation}) async {
    try {
      // Create a GeoFirePoint for "User Location"
      GeoFirePoint center = GeoFirePoint(userLocation);

      // Reference to locations collection.
      final CollectionReference<Map<String, dynamic>> locationCollectionRef =
          _fireStore.collection('stores');

      // Get the documents within a 3 km radius of "Akota Garden"
      final result =
          await GeoCollectionReference(locationCollectionRef).fetchWithin(
        center: center,
        radiusInKm: 3,
        // todo make it dynamic via constant
        field: 'geo',
        strictMode: true,
        geopointFrom: geopointFrom,
      );

      final List<Stores> stores = [];

      for (var value in result) {
        /*String storeId= value.id;
        final distance =
            center.distanceBetweenInKm(geopoint: value['location']);
        print("StoreName : $storeId == Distance : $distance");*/

        stores.add(Stores(
          id: value.id,
          name: value['name'],
          adress: value['adress'],
          zipCodesList: [],
          logo: value['logo'],
        ));
      }

      return stores;
    } catch (e) {
      print("ERROR IN LOCATION : $e");
      return [];
    }
  }


  Future<void> addProductToUserList(BuildContext context,
      {required Product product, required String userListId}) async {

    print(userListId);

    CollectionReference userProductList = _fireStore
        .collection(MyList.collectionName)
        .doc(userListId)
        .collection(UserProductListCollection.collectionName);

    final query = await userProductList
        .where(ProductCollectionConstant.productId, isEqualTo: product.productId)
        .limit(1)
        .get();

    var isProductExist = query.docs.isNotEmpty;

    if (isProductExist) {
      context.showSnackBar(message: "Product Already Exist in the List");
      return;
    }

    final userProduct = UserProductInsert(
      productId: _fireStore.collection(ProductCollectionConstant.collectionName).doc(product.productId),
    );

    userProductList
        .add(userProduct.toJson())
        .then((value) => context.pop('User Product Inserted'));
  }



  Future<void> findNearbyLocations() async {
    Future.delayed(Duration.zero);

    try {
      // Query for "Akota Garden" location
      QuerySnapshot querySnapshot = await _fireStore
          .collection('locations')
          .where('place_name', isEqualTo: 'Akota Garden')
          .get();

      // Get the first document from the query result
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Get the coordinates of "Akota Garden"
      GeoPoint akotaGardenLocation = documentSnapshot['coordinates'];

      // Create a GeoFirePoint for "Akota Garden"
      GeoFirePoint center = GeoFirePoint(akotaGardenLocation);

      /*final double distance = center.distance(lat: 22.2964, lng: 73.1647);
      print(distance.toString());*/

      // Reference to locations collection.
      final CollectionReference<Map<String, dynamic>> locationCollectionRef =
      _fireStore.collection('locations');

      // Get the documents within a 3 km radius of "Akota Garden"
      final result =
      await GeoCollectionReference(locationCollectionRef).fetchWithin(
        center: center,
        radiusInKm: 3,
        field: 'geo',
        strictMode: true,
        geopointFrom: geopointFrom,
      );

      for (var value in result) {
        String placeName = value['place_name'];
        final distance =
        center.distanceBetweenInKm(geopoint: value['coordinates']);

        print(placeName);
        print("Distance : $distance");
      }
    } catch (e) {
      print("ERROR IN LOCATION : $e");
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

/*Future<void> searchProducts({String query = ""}) async {
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
  }*/
}


