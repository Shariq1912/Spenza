import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/login/data/login_request.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class LoginRepository extends StateNotifier<ApiResponse>
    with FirstTimeLoginMixin {
  LoginRepository() : super(const ApiResponse());
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _storeData(UserCredential userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(UserConstant.userIdField, userCredential.user!.uid);
    await prefs.setBool('is_login', true);
    await prefs.setBool(
      'is_first_login',
      await isFirstTimeLogin(
        firestore: _fireStore,
        userId: userCredential.user!.uid,
      ),
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
        debugPrint("IS FIRST LOGIN === $userData");
        return !(userData.containsKey(UserConstant.zipCodeField) &&
            userData[UserConstant.zipCodeField] != "");
      }

      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required LoginRequest credentials}) async {
    try {
      state = ApiResponse.loading();

      final alreadyUser =
          await _auth.fetchSignInMethodsForEmail(credentials.email);
      if (alreadyUser.isEmpty) {
        state = ApiResponse.error(errorMsg: "User is not registered");
        return;
      }

      // todo check user credentials and show error when credentials wrong!
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );

      await _storeData(userCredential);
      state = ApiResponse.success(data: userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        state = ApiResponse.error(errorMsg: "No user found for that email");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        state = ApiResponse.error(errorMsg: "Invalid email or password");
      }
    } catch (error) {
      // state = ApiResponse.error(errorMsg: error.toString());
      state = ApiResponse.error(errorMsg: "Invalid email or password");
    }
  }

  Future<bool> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    final pref = await SharedPreferences.getInstance();

    return pref.clear().then((value) => true);
  }


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final userCredential = authResult;

      if (userCredential != null) {
        await _storeData(userCredential);
        state = ApiResponse.success(data: userCredential);
      } else {
        state = ApiResponse.error(errorMsg: 'Failed to sign in with Google.');
      }
    } catch (e) {
      state = ApiResponse.error(errorMsg: e.toString());
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
