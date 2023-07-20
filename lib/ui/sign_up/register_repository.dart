import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../login/data/login_request.dart';
import '../login/data/user.dart';

class RegisterRepository extends StateNotifier<ApiResponse>{
  RegisterRepository(): super(const ApiResponse());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _storeData(UserCredential userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userCredential.user!.uid);
    await prefs.setBool('is_login', true);
    await prefs.setBool(
      'is_first_login',
      await _isFirstTimeLogin(userCredential.user!.uid),
    );
  }

  Future<bool> _isFirstTimeLogin(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _fireStore
          .collection(UserConstant.userCollection)
          .where(UserConstant.userIdField, isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        return !(userData.containsKey(UserConstant.zipCodeField) &&
            userData[UserConstant.zipCodeField] != "");
      }

      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> registerWithEmailAndPassword(
      {required LoginRequest credentials}) async {
    try {
      state = ApiResponse.loading();

      /// Checks if user already registered
      final alreadyUser = await _auth.fetchSignInMethodsForEmail(credentials.email);
      if (alreadyUser.isNotEmpty) {
        state = ApiResponse.error(errorMsg: "User is already registered");
        return;
      }
      final userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      state = ApiResponse.success(data: userCredential.user);
      await _storeData(userCredential);

      /// insert the same in firestore db
      final user = Users(
          uid: userCredential.user!.uid,
          email: credentials.email
      );
      await _fireStore.collection('users').doc(user.uid).set(user.toJson());
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        state = ApiResponse.error(errorMsg: 'The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        state = ApiResponse.error(errorMsg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    catch (error) {
      state = ApiResponse.error(errorMsg: error.toString());
    }
  }


  Future<void> redirectUserToDestination({
    required BuildContext context,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isFirstTimeLogin = prefs.isFirstLogin();

    if (!isFirstTimeLogin) {
      context.goNamed(RouteManager.homeScreen);
      return;
    }

    context.goNamed(RouteManager.locationScreen);
  }

}