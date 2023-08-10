import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin FirestoreAndPrefsMixin {
  FirebaseFirestore get fireStore => FirebaseFirestore.instance;
  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }

}