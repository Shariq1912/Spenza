import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GenericNameRecord extends FirestoreRecord {
  GenericNameRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "genericName" field.
  String? _genericName;
  String get genericName => _genericName ?? '';
  bool hasGenericName() => _genericName != null;

  // "genericURL" field.
  String? _genericURL;
  String get genericURL => _genericURL ?? '';
  bool hasGenericURL() => _genericURL != null;

  void _initializeFields() {
    _genericName = snapshotData['genericName'] as String?;
    _genericURL = snapshotData['genericURL'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('genericName');

  static Stream<GenericNameRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GenericNameRecord.fromSnapshot(s));

  static Future<GenericNameRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GenericNameRecord.fromSnapshot(s));

  static GenericNameRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GenericNameRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GenericNameRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GenericNameRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GenericNameRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GenericNameRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGenericNameRecordData({
  String? genericName,
  String? genericURL,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'genericName': genericName,
      'genericURL': genericURL,
    }.withoutNulls,
  );

  return firestoreData;
}
