// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future deleteMyList(
  MylistRecord myList,
  List<ProductsRecord> products,
) async {
  // Delete myList document
  await FirebaseFirestore.instance
      .collection('mylist')
      .doc(myList.reference.id)
      .delete();

  // Update products to remove myList reference from bmyListRef
  final batch = FirebaseFirestore.instance.batch();

  for (var product in products) {
    if (product.bmyListRef?.contains(myList.reference) ?? false) {
      final updatedBmyListRef = product.bmyListRef?.toList();
      updatedBmyListRef?.remove(myList.reference);

      batch.update(
        FirebaseFirestore.instance
            .collection('products')
            .doc(product.reference.id),
        {'bmyListRef': updatedBmyListRef},
      );
    }
  }

  await batch.commit();
}
