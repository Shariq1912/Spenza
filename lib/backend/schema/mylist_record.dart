import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MylistRecord extends FirestoreRecord {
  MylistRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "usersRef" field.
  DocumentReference? _usersRef;
  DocumentReference? get usersRef => _usersRef;
  bool hasUsersRef() => _usersRef != null;

  // "myListPhoto" field.
  String? _myListPhoto;
  String get myListPhoto => _myListPhoto ?? '';
  bool hasMyListPhoto() => _myListPhoto != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _usersRef = snapshotData['usersRef'] as DocumentReference?;
    _myListPhoto = snapshotData['myListPhoto'] as String?;
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('mylist');

  static Stream<MylistRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MylistRecord.fromSnapshot(s));

  static Future<MylistRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MylistRecord.fromSnapshot(s));

  static MylistRecord fromSnapshot(DocumentSnapshot snapshot) => MylistRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MylistRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MylistRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MylistRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MylistRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMylistRecordData({
  String? name,
  DocumentReference? usersRef,
  String? myListPhoto,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'usersRef': usersRef,
      'myListPhoto': myListPhoto,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}
