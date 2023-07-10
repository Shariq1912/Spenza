import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../network/api_responses.dart';

class GoogleLoginRepository {
  Future<ApiResponse<UserCredential>> signInWithGoogle() async {
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
        return ApiResponse.success(data: userCredential);
      } else {
        return ApiResponse.error(errorMsg: 'Failed to sign in with Google.');
      }
    } catch (e) {
      return ApiResponse.error(errorMsg: e.toString());
    }
  }
}
