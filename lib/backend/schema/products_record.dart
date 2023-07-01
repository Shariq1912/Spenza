import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductsRecord extends FirestoreRecord {
  ProductsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "pImage" field.
  String? _pImage;
  String get pImage => _pImage ?? '';
  bool hasPImage() => _pImage != null;

  // "genericNameRef" field.
  DocumentReference? _genericNameRef;
  DocumentReference? get genericNameRef => _genericNameRef;
  bool hasGenericNameRef() => _genericNameRef != null;

  // "departmentRef" field.
  DocumentReference? _departmentRef;
  DocumentReference? get departmentRef => _departmentRef;
  bool hasDepartmentRef() => _departmentRef != null;

  // "measure" field.
  String? _measure;
  String get measure => _measure ?? '';
  bool hasMeasure() => _measure != null;

  // "bPrice" field.
  double? _bPrice;
  double get bPrice => _bPrice ?? 0.0;
  bool hasBPrice() => _bPrice != null;

  // "bmyListRef" field.
  List<DocumentReference>? _bmyListRef;
  List<DocumentReference> get bmyListRef => _bmyListRef ?? const [];
  bool hasBmyListRef() => _bmyListRef != null;

  // "bstoreRef" field.
  DocumentReference? _bstoreRef;
  DocumentReference? get bstoreRef => _bstoreRef;
  bool hasBstoreRef() => _bstoreRef != null;

  // "idStore" field.
  String? _idStore;
  String get idStore => _idStore ?? '';
  bool hasIdStore() => _idStore != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  bool hasDepartment() => _department != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _pImage = snapshotData['pImage'] as String?;
    _genericNameRef = snapshotData['genericNameRef'] as DocumentReference?;
    _departmentRef = snapshotData['departmentRef'] as DocumentReference?;
    _measure = snapshotData['measure'] as String?;
    _bPrice = castToType<double>(snapshotData['bPrice']);
    _bmyListRef = getDataList(snapshotData['bmyListRef']);
    _bstoreRef = snapshotData['bstoreRef'] as DocumentReference?;
    _idStore = snapshotData['idStore'] as String?;
    _department = snapshotData['department'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductsRecord.fromSnapshot(s));

  static Future<ProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductsRecord.fromSnapshot(s));

  static ProductsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductsRecordData({
  String? name,
  DateTime? createdAt,
  DateTime? modifiedAt,
  String? pImage,
  DocumentReference? genericNameRef,
  DocumentReference? departmentRef,
  String? measure,
  double? bPrice,
  DocumentReference? bstoreRef,
  String? idStore,
  String? department,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'pImage': pImage,
      'genericNameRef': genericNameRef,
      'departmentRef': departmentRef,
      'measure': measure,
      'bPrice': bPrice,
      'bstoreRef': bstoreRef,
      'idStore': idStore,
      'department': department,
    }.withoutNulls,
  );

  return firestoreData;
}
