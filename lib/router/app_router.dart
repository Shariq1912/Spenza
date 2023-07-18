import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/favourite_stores/favourite_store_screen.dart';
import 'package:spenza/ui/home/home_screen.dart';
import 'package:spenza/ui/location/location_screen.dart';
import 'package:spenza/ui/login/login_screen.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/ui/sign_up/sign_up_screen.dart';
import 'package:spenza/ui/splash/splash_route.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../ui/profile/component/add_list.dart';
import '../ui/settings/setting_Screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

/// For Bottom Navigation if required
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashScreen = '/';

  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String locationScreen = '/locationScreen';
  static const String favouriteScreen = '/favouriteScreen';
  static const String homeScreen = '/homeScreen';
  static const String settingScreen = '/settingScreen';
  static const String profileScreen = '/profileScreen';
  static const String addListScreen = '/addListScreen';

  /// The route configuration.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        name: splashScreen,
        path: splashScreen,
        builder: (context, state) {
          return const SplashScreen();
          // return const LoginScreen();
        },
      ),
      GoRoute(
        name: registerScreen,
        path: registerScreen,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        name: loginScreen,
        path: loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: locationScreen,
        path: locationScreen,
        builder: (context, state) {
          return const LocationScreen();
        },
      ),
      GoRoute(
        name: favouriteScreen,
        path: favouriteScreen,
        builder: (context, state) {
          return FavouriteStoreScreen(null);
        },
      ),

      GoRoute(
        name: homeScreen,
        path: homeScreen,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),

      GoRoute(
        name: settingScreen,
        path: settingScreen,
        builder: (context, state) {
          return const SettingScreen();
        },
      ),
      GoRoute(
        name: profileScreen,
        path: profileScreen,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        name: addListScreen,
        path: addListScreen,
        builder: (context, state) {
          return const AddItemToList();
        },
      ),
    ],
    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.isUserLoggedIn() ? favouriteScreen : null;
    },
  );
}
