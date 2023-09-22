import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'splash_provider.g.dart';

@riverpod
class Splash extends _$Splash with FirstTimeLoginMixin {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<String?> build() async {
    return null;
  }

  Future<void> isLoggedIn() async {
    state = AsyncValue.loading();

    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.isUserLoggedIn();

    Future.delayed(Duration.zero);
    final isFirstLogin = await isFirstTimeLogin(
      firestore: _fireStore,
      userId: prefs.getUserId(),
    );

    if (!isLogin) {
      // Not logged in
      if (isFirstLogin) {
        state = AsyncValue.data(RouteManager.openingScreen);
      } else {
        state = AsyncValue.data(RouteManager.loginScreen);
      }
    } else {
      // Logged in
      if (isFirstLogin) {
        state = AsyncValue.data(RouteManager.locationScreen);
      } else {
        state = AsyncValue.data(RouteManager.homeScreen);
      }
    }
  }

}
