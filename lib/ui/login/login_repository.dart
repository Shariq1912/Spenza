import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/login/data/login_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRepository extends StateNotifier<ApiResponse> {
  LoginRepository() : super(const ApiResponse());

  Future<void> _storeData(UserCredential userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userCredential.user!.uid);
    await prefs.setBool('is_login', true);
  }

  Future<void> loginWithEmailAndPassword(
      {required LoginRequest credentials}) async {
    try {
      state = ApiResponse.loading();
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      state = ApiResponse.success(data: userCredential.user);
      await _storeData(userCredential);


    } catch (error) {
      state = ApiResponse.error(errorMsg: '$error');
    }
  }



  Future<void> registerWithEmailAndPassword(
      {required LoginRequest credentials}) async {
    try {
      state = ApiResponse.loading();
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      state = ApiResponse.success(data: userCredential.user);
      await _storeData(userCredential);

      // insert the same in firestore db
      final user = User(
        uid: userCredential.user!.uid,
        email: credentials.email,
      );
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toJson());




    } catch (error) {
      state = ApiResponse.error(errorMsg: '$error');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await SharedPreferences.getInstance()
      ..clear();
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
      //final userCredential = authResult.user;  if get error try to uncomment this line
      final userCredential = authResult;

      if (userCredential != null) {
        state = ApiResponse.success(data: userCredential);
      } else {
        state = ApiResponse.error(errorMsg: 'Failed to sign in with Google.');
      }
    } catch (e) {
      state = ApiResponse.error(errorMsg: e.toString());
    }
  }
}
