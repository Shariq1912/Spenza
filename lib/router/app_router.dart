import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/add_product/add_product_screen.dart';
import 'package:spenza/ui/dashboard/dashboard_screen.dart';
import 'package:spenza/ui/favourite_stores/favourite_store_screen.dart';
import 'package:spenza/ui/home/components/add_list.dart';
import 'package:spenza/ui/home/components/new_list_dialog.dart';
import 'package:spenza/ui/home/edit_list_screen.dart';
import 'package:spenza/ui/home/home_screen.dart';
import 'package:spenza/ui/location/location_screen.dart';
import 'package:spenza/ui/login/login_screen.dart';
import 'package:spenza/ui/matching_store/matching_store_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_details_screen.dart';
import 'package:spenza/ui/my_store_products/my_store_product.dart';
import 'package:spenza/ui/pre_loaded_list_details/pre_loaded_list_details_screen.dart';
import 'package:spenza/ui/preloaded_list_screen/preloaded_list_screen.dart';
import 'package:spenza/ui/profile/component/edit_profile_info.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/ui/receipts/display_receipt.dart';
import 'package:spenza/ui/receipts/upload_receipt.dart';
import 'package:spenza/ui/selected_store/selected_store_screen.dart';
import 'package:spenza/ui/settings/setting_screen.dart';
import 'package:spenza/ui/sign_up/register_screen.dart';
import 'package:spenza/ui/splash/splash_screen.dart';
import 'package:spenza/ui/webview_screen/webview_screen.dart';

import '../ui/my_store/my_store.dart';
import '../ui/receipts/upload_receipt_screen.dart';
import '../ui/splash/provider/splash_widget.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

/// For Bottom Navigation if required
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashWidget = '/';
  static const String splashScreen = '/splashScreen';

  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String locationScreen = '/locationScreen';
  static const String favouriteScreen = '/favouriteScreen';
  static const String homeScreen = '/homeScreen';
  static const String myListDetailScreen = '/myListDetailScreen';
  static const String myListScreen = '/myListScreen';
  static const String preLoadedListDetailScreen = '/preLoadedListDetailScreen';
  static const String storeRankingScreen = '/storeMatchingScreen';
  static const String selectedStoreScreen = '/selectedStoreScreen';
  static const String addProductScreen = '/addProductScreen';
  static const String addNewList = '/addNewList';
  static const String editListScreen = '/editListScreen';
  static const String addProductToNewList = '/addProductToNewList';
  static const String storesScreen = '/storesScreen';
  static const String myStoreProductScreen = '/myStoreProductScreen';
  static const String settingScreen = '/settingScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String uploadReceiptScreen = '/uploadReceiptScreen';
  static const String displayReceiptScreen = '/displayReceiptScreen';
  static const String preLoadedListScreen = '/preLoadedListScreen';
  static const String webViewScreen = '/webViewScreen';

  static const bottomNavPath = 'bottom_navigation';
  static const storeScreenBottomPath = '/storeScreenBottomPath';
  static const settingsScreenBottomPath = '/settingsScreenBottomPath';
  static const myListScreenBottomPath = '/myListScreenBottomPath';
  static const preloadedListScreenBottomPath = '/preloadedListScreenBottomPath';
  static const receiptListScreenBottomPath = '/receiptListScreenBottomPath';

  /// The route configuration.
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(
              key: state.pageKey, navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey(debugLabel: "home"),
            routes: [
              GoRoute(
                name: homeScreen,
                path: "/shell/home",
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: HomeScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey(debugLabel: "my_list"),
            routes: [
              GoRoute(
                name: myListScreenBottomPath,
                path: "/shell/my_list",
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: MyListScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey(debugLabel: "receipts"),
            routes: [
              GoRoute(
                name: receiptListScreenBottomPath,
                path: "/shell/receipts",
                pageBuilder: (context, state) {
                  final String path = state.queryParameters['list_ref'] ?? "";
                  return NoTransitionPage(
                    child: DisplayReceiptScreen(key: state.pageKey, path: path),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey(debugLabel: "settings"),
            routes: [
              GoRoute(
                name: settingsScreenBottomPath,
                path: "/shell/settings",
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: SettingScreen(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: splashWidget,
        path: splashWidget,
        builder: (context, state) {
          return SplashWidget();
          // return const LoginScreen();
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: splashScreen,
        path: splashScreen,
        builder: (context, state) {
          return SplashScreen();
          // return const LoginScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: registerScreen,
        path: registerScreen,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: loginScreen,
        path: loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: locationScreen,
        path: locationScreen,
        builder: (context, state) {
          /// Once Login or Register redirects to here.
          return const LocationScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: favouriteScreen,
        path: favouriteScreen,
        builder: (context, state) {
          /// Checks whether it's first time login or register when coming from location screen.
          return FavouriteStoreScreen(null);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: myListDetailScreen,
        path: myListDetailScreen,
        builder: (context, state) {
          final String listId =
              state.queryParameters['list_id'] ?? "4NlYnhmchdlu528Gw2yK";
          final String name = state.queryParameters['name'] ?? "preloaded";
          final String photo = state.queryParameters['photo'] ?? "";
          final String path = state.queryParameters['path'] ?? "";
          //return MyListDetailsScreen(listId: listId);

          return MyListDetailsScreen(
              listId: listId, name: name, photo: photo, path: path);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: preLoadedListDetailScreen,
        path: preLoadedListDetailScreen,
        builder: (context, state) {
          final String listId =
              state.queryParameters['list_id'] ?? "4NlYnhmchdlu528Gw2yK";
          final String name = state.queryParameters['name'] ?? "preloaded";
          final String photo = state.queryParameters['photo'] ?? "";
          return PreLoadedListDetailsScreen(
              listId: listId, name: name, photo: photo);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: addProductScreen,
        path: addProductScreen,
        builder: (context, state) {
          final String query = state.queryParameters['query'] ?? "";
          return AddProductScreen(query: query);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: storeRankingScreen,
        path: storeRankingScreen,
        builder: (context, state) {
          return MatchingStoreScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: selectedStoreScreen,
        path: selectedStoreScreen,
        builder: (context, state) {
          return SelectedStoreScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: addNewList,
        path: addNewList,
        builder: (context, state) {
          return NewMyList();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: editListScreen,
        path: editListScreen,
        builder: (context, state) {
          return EditListScreen();
        },
      ),
      GoRoute(
        name: storesScreen,
        path: storesScreen,
        parentNavigatorKey: _rootNavigator,
        builder: (context, state) {
          return AllStoresScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: myStoreProductScreen,
        path: myStoreProductScreen,
        builder: (context, state) {
          final String storeId = state.queryParameters['store_id'] ?? "";
          final String logo = state.queryParameters['logo'] ?? "";
          final String? listId = state.queryParameters['list_id'];

          return MyStoreProduct(storeId: storeId, logo: logo, listId: listId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: settingScreen,
        path: settingScreen,
        builder: (context, state) {
          return SettingScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: profileScreen,
        path: profileScreen,
        builder: (context, state) {
          return ProfileScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: uploadReceiptScreen,
        path: uploadReceiptScreen,
        builder: (context, state) {
          final String path = state.queryParameters['list_id'] ?? "";
          //return MyListDetailsScreen(listId: listId);
          if (path != "") {
            print("Notequal $path");
            return UploadReceiptScreen(path: path);
          } else {
            print("equal $path");
            return UploadReceiptScreen(path: path); // For example
          }
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: displayReceiptScreen,
        path: displayReceiptScreen,
        builder: (context, state) {
          final String path = state.queryParameters['list_ref'] ?? "";
          return DisplayReceiptScreen(
            key: state.pageKey,
            path: path,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: preLoadedListScreen,
        path: preLoadedListScreen,
        builder: (context, state) {
          return PreloadedListScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: editProfileScreen,
        path: editProfileScreen,
        builder: (context, state) {
          return EditProfileInformation();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: myListScreen,
        path: myListScreen,
        builder: (context, state) {
          return MyListScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: webViewScreen,
        path: webViewScreen,
        builder: (context, state) {
          final String storeId = state.queryParameters['url'] ?? "";
          return WebViewScreen(url: storeId);
        },
      ),
    ],
  );
}
