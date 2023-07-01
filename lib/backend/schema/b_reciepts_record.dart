import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BRecieptsRecord extends FirestoreRecord {
  BRecieptsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "bmyListRef" field.
  DocumentReference? _bmyListRef;
  DocumentReference? get bmyListRef => _bmyListRef;
  bool hasBmyListRef() => _bmyListRef != null;

  // "recieptPhoto" field.
  String? _recieptPhoto;
  String get recieptPhoto => _recieptPhoto ?? '';
  bool hasRecieptPhoto() => _recieptPhoto != null;

  // "bstoreRef" field.
  DocumentReference? _bstoreRef;
  DocumentReference? get bstoreRef => _bstoreRef;
  bool hasBstoreRef() => _bstoreRef != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _bmyListRef = snapshotData['bmyListRef'] as DocumentReference?;
    _recieptPhoto = snapshotData['recieptPhoto'] as String?;
    _bstoreRef = snapshotData['bstoreRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bReciepts');

  static Stream<BRecieptsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BRecieptsRecord.fromSnapshot(s));

  static Future<BRecieptsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BRecieptsRecord.fromSnapshot(s));

  static BRecieptsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BRecieptsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BRecieptsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BRecieptsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BRecieptsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BRecieptsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBRecieptsRecordData({
  DocumentReference? userRef,
  DocumentReference? bmyListRef,
  String? recieptPhoto,
  DocumentReference? bstoreRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'bmyListRef': bmyListRef,
      'recieptPhoto': recieptPhoto,
      'bstoreRef': bstoreRef,
    }.withoutNulls,
  );

  return firestoreData;
}
