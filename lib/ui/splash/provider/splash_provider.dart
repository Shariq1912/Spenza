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
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.isUserLoggedIn();

    state = AsyncValue.loading();
    if (!isLogin) {
      state = AsyncValue.data(null);
      return;
    }

    // final isFirstLogin = prefs.isFirstLogin();
    final isFirstLogin = await isFirstTimeLogin(prefs.getUserId());
    if (!isFirstLogin) {
      state = AsyncValue.data(RouteManager.homeScreen);
    } else {
      /// Redirect to Location screen for location and zip code purpose then make user to select favourite stores.
      state = AsyncValue.data(RouteManager.locationScreen);
    }
  }

}
