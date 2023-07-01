import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _confirmValue = prefs.getBool('ff_confirmValue') ?? _confirmValue;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _searchActive = false;
  bool get searchActive => _searchActive;
  set searchActive(bool _value) {
    _searchActive = _value;
  }

  bool _searchActive2 = false;
  bool get searchActive2 => _searchActive2;
  set searchActive2(bool _value) {
    _searchActive2 = _value;
  }

  bool _searchActiveMyList = false;
  bool get searchActiveMyList => _searchActiveMyList;
  set searchActiveMyList(bool _value) {
    _searchActiveMyList = _value;
  }

  bool _searchActiveStores = false;
  bool get searchActiveStores => _searchActiveStores;
  set searchActiveStores(bool _value) {
    _searchActiveStores = _value;
  }

  bool _confirmValue = false;
  bool get confirmValue => _confirmValue;
  set confirmValue(bool _value) {
    _confirmValue = _value;
    prefs.setBool('ff_confirmValue', _value);
  }

  bool _searchAddProduct = false;
  bool get searchAddProduct => _searchAddProduct;
  set searchAddProduct(bool _value) {
    _searchAddProduct = _value;
  }

  bool _searchActiveAddProducts = false;
  bool get searchActiveAddProducts => _searchActiveAddProducts;
  set searchActiveAddProducts(bool _value) {
    _searchActiveAddProducts = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
