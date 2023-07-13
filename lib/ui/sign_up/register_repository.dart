import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';

import '../login/data/login_request.dart';
import '../login/data/user.dart';

class RegisterRepository extends StateNotifier<ApiResponse>{
  RegisterRepository(): super(const ApiResponse());

  Future<void> _storeData(UserCredential userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userCredential.user!.uid);
    await prefs.setBool('is_login', true);
  }

  Future<void> registerWithEmailAndPassword(
      {required LoginRequest credentials}) async {
    try {
      state = ApiResponse.loading();
      final alreadyUser = await FirebaseAuth.instance.fetchSignInMethodsForEmail(credentials.email);
      if (alreadyUser.isNotEmpty) {
        state = ApiResponse.error(errorMsg: "user is already registered");
        return;
      }
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      state = ApiResponse.success(data: userCredential.user);
      await _storeData(userCredential);

      // insert the same in firestore db


      final user = Users(
          uid: userCredential.user!.uid,
          email: credentials.email
      );
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toJson());
    } catch (error) {
      state = ApiResponse.error(errorMsg: '$error');
    }
  }

}