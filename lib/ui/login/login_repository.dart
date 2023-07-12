import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spenza/network/api_responses.dart';

class LoginRepository extends StateNotifier<ApiResponse> {
  LoginRepository() : super(const ApiResponse());

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
