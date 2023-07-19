import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';

class MyStoreRepository extends StateNotifier<ApiResponse> {
  MyStoreRepository() : super(const ApiResponse());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AllStores>> fetchAllStores() async {
    state = ApiResponse.loading();
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('stores').get();

      List<AllStores> allStores = snapshot.docs.map((doc) {
        final data = doc.data();
        final allStore = AllStores.fromJson(data);
        return allStore;
      }).toList();
      print(" allStoreLength ${allStores.length}");
      allStores.forEach((element) {
        print(" allStoresItems ${element.name}");
      });
      state = ApiResponse.success(data: allStores);
      return allStores;

    } catch (error) {
      state = ApiResponse.error(
        errorMsg: 'Error occurred while fetching stores: $error',
      );
      return [];
    }
  }
}
