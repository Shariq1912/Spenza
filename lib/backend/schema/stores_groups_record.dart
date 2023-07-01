import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoresGroupsRecord extends FirestoreRecord {
  StoresGroupsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "logo" field.
  String? _logo;
  String get logo => _logo ?? '';
  bool hasLogo() => _logo != null;

  // "storesRef" field.
  List<DocumentReference>? _storesRef;
  List<DocumentReference> get storesRef => _storesRef ?? const [];
  bool hasStoresRef() => _storesRef != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _logo = snapshotData['logo'] as String?;
    _storesRef = getDataList(snapshotData['storesRef']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('storesGroups');

  static Stream<StoresGroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StoresGroupsRecord.fromSnapshot(s));

  static Future<StoresGroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StoresGroupsRecord.fromSnapshot(s));

  static StoresGroupsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StoresGroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StoresGroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StoresGroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StoresGroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoresGroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoresGroupsRecordData({
  String? name,
  String? logo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'logo': logo,
    }.withoutNulls,
  );

  return firestoreData;
}
