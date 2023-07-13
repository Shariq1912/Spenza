import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ImageExtension on String {
  String get assetImageUrl {
    return 'assets/images/$this';
  }
}

extension SnackbarExtension on BuildContext {
  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

extension SharedPreferencesExtension on SharedPreferences {
  String getUserId() {
    return getString('uid')!;
  }

  bool isUserLoggedIn() {
    return getBool('is_login') ?? false;
  }
}
