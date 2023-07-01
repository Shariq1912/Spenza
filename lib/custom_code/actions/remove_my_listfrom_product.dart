// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future removeMyListfromProduct(
  DocumentReference myList,
  ProductsRecord product,
) async {
  // Update product to remove myList reference from bmyListRef
  final updatedBmyListRef = List.from(product.bmyListRef ?? []);
  updatedBmyListRef.remove(myList);

  await FirebaseFirestore.instance
      .collection('products')
      .doc(product.reference.id)
      .update({'bmyListRef': updatedBmyListRef}); // Edited
}
