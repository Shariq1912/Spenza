import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/utils/firestore_constants.dart';

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

  bool isFirstLogin() {
    return getBool('is_first_login') ?? true;
  }
}

mixin FirstTimeLoginMixin {
  Future<bool> isFirstTimeLogin(
      {required FirebaseFirestore firestore, required String userId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(UserConstant.userCollection)
          .where(UserConstant.userIdField, isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        debugPrint("IS FIRST LOGIN === $userData");
        return !(userData.containsKey(UserConstant.zipCodeField) &&
            userData[UserConstant.zipCodeField] != "");
      }

      return false;
    } catch (error) {
      return false;
    }
  }
}
