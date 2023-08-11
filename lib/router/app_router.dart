import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/add_product/add_product_screen.dart';
import 'package:spenza/ui/favourite_stores/favourite_store_screen.dart';
import 'package:spenza/ui/home/components/add_list.dart';
import 'package:spenza/ui/home/home_screen.dart';
import 'package:spenza/ui/location/location_screen.dart';
import 'package:spenza/ui/login/login_screen.dart';
import 'package:spenza/ui/matching_store/matching_store_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_details_screen.dart';
import 'package:spenza/ui/pre_loaded_list_details/pre_loaded_list_details_screen.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/ui/receipts/upload_receipt.dart';
import 'package:spenza/ui/selected_store/selected_store_screen.dart';
import 'package:spenza/ui/settings/setting_Screen.dart';
import 'package:spenza/ui/sign_up/register_screen.dart';
import 'package:spenza/ui/splash/splash_screen.dart';

import '../ui/my_store/my_store.dart';

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
  static const String myListDetailScreen = '/myListDetailScreen';
  static const String preLoadedListDetailScreen = '/preLoadedListDetailScreen';
  static const String storeRankingScreen = '/storeMatchingScreen';
  static const String selectedStoreScreen = '/selectedStoreScreen';
  static const String addProductScreen = '/addProductScreen';
  static const String addNewList = '/addNewList';
  static const String addProductToNewList = '/addProductToNewList';
  static const String stores = '/stores';
  static const String settingScreen = '/settingScreen';
  static const String profileScreen = '/profileScreen';
  static const String uploadReceiptScreen = '/uploadReceiptScreen';

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
          final String listId = state.queryParameters['list_id'] ?? "4NlYnhmchdlu528Gw2yK";
          return MyListDetailsScreen(listId: listId);
        },
      ),
      GoRoute(
        name: preLoadedListDetailScreen,
        path: preLoadedListDetailScreen,
        builder: (context, state) {
          final String listId = state.queryParameters['list_id'] ?? "4NlYnhmchdlu528Gw2yK";
          return PreLoadedListDetailsScreen(listId: listId);
        },
      ),

      GoRoute(
        name: addProductScreen,
        path: addProductScreen,
        builder: (context, state) {
          final String query = state.queryParameters['query'] ?? "";
          return AddProductScreen(query: query);
        },
      ),

      GoRoute(
        name: storeRankingScreen,
        path: storeRankingScreen,
        builder: (context, state) {
          return MatchingStoreScreen();
        },
      ),

      GoRoute(
        name: selectedStoreScreen,
        path: selectedStoreScreen,
        builder: (context, state) {
          return SelectedStoreScreen();
        },
      ),

      GoRoute(
        name: addNewList,
        path: addNewList,
        builder: (context, state) {
          return AddItemToList();
        },
      ),

      GoRoute(
        name: stores,
        path: stores,
        builder: (context, state) {
          return Stores();
        },
      ),

      GoRoute(
        name: settingScreen,
        path: settingScreen,
        builder: (context, state) {
          return SettingScreen();
        },
      ),

      GoRoute(
        name: profileScreen,
        path: profileScreen,
        builder: (context, state) {
          return ProfileScreen();
        },
      ),

      GoRoute(
        name: uploadReceiptScreen,
        path: uploadReceiptScreen,
        builder: (context, state) {
          return UploadReceipt();
        },
      ),
    ],
  );
}
