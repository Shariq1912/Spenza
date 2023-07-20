import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/ui/add_product/add_product_screen.dart';
import 'package:spenza/ui/favourite_stores/favourite_store_screen.dart';
import 'package:spenza/ui/home/home_screen.dart';
import 'package:spenza/ui/location/location_screen.dart';
import 'package:spenza/ui/login/login_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_details_screen.dart';
import 'package:spenza/ui/sign_up/register_screen.dart';
import 'package:spenza/ui/splash/splash_screen.dart';
import 'package:spenza/utils/spenza_extensions.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

/// For Bottom Navigation if required
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashScreen = '/myListDetailScreen';

  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String locationScreen = '/locationScreen';
  static const String favouriteScreen = '/favouriteScreen';
  static const String homeScreen = '/homeScreen';
  static const String myListDetailScreen = '/';
  static const String addProductScreen = '/addProductScreen';

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
          return const RegisterScreen();
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
          /// Once Login or Register redirects to here.
          return const LocationScreen();
        },
      ),
      GoRoute(
        name: favouriteScreen,
        path: favouriteScreen,
        builder: (context, state) {
          /// Checks whether it's first time login or register when coming from location screen.
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
        name: myListDetailScreen,
        path: myListDetailScreen,
        builder: (context, state) {
          return const MyListDetailsScreen();
        },
      ),
      GoRoute(
        name: addProductScreen,
        path: addProductScreen,
        builder: (context, state) {
          return const AddProductScreen();
        },
      ),
    ],
  );
}
