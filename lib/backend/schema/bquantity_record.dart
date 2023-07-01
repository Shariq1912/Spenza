import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BquantityRecord extends FirestoreRecord {
  BquantityRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "productRef" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  bool hasProductRef() => _productRef != null;

  // "myListRef" field.
  DocumentReference? _myListRef;
  DocumentReference? get myListRef => _myListRef;
  bool hasMyListRef() => _myListRef != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  void _initializeFields() {
    _productRef = snapshotData['productRef'] as DocumentReference?;
    _myListRef = snapshotData['myListRef'] as DocumentReference?;
    _quantity = castToType<int>(snapshotData['quantity']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bquantity');

  static Stream<BquantityRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BquantityRecord.fromSnapshot(s));

  static Future<BquantityRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BquantityRecord.fromSnapshot(s));

  static BquantityRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BquantityRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BquantityRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BquantityRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BquantityRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BquantityRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBquantityRecordData({
  DocumentReference? productRef,
  DocumentReference? myListRef,
  int? quantity,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'productRef': productRef,
      'myListRef': myListRef,
      'quantity': quantity,
    }.withoutNulls,
  );

  return firestoreData;
}
