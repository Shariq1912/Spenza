import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/add_product/add_product_screen.dart';
import 'package:spenza/ui/dashboard/dashboard_screen.dart';
import 'package:spenza/ui/favourite_stores/favourite_store_screen.dart';
import 'package:spenza/ui/home/components/new_list_dialog.dart';
import 'package:spenza/ui/home/edit_list_screen.dart';
import 'package:spenza/ui/home/home_screen.dart';
import 'package:spenza/ui/location/location_screen.dart';
import 'package:spenza/ui/login/login_screen.dart';
import 'package:spenza/ui/matching_store/matching_store_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_details_screen.dart';
import 'package:spenza/ui/my_list_details/my_list_screen.dart';
import 'package:spenza/ui/my_store_products/my_store_product.dart';
import 'package:spenza/ui/pre_loaded_list_details/pre_loaded_list_details_screen.dart';
import 'package:spenza/ui/preloaded_list_screen/preloaded_list_screen.dart';
import 'package:spenza/ui/profile/component/edit_profile_info.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/ui/receipts/display_receipt.dart';
import 'package:spenza/ui/selected_store/selected_store_screen.dart';
import 'package:spenza/ui/settings/setting_screen.dart';
import 'package:spenza/ui/sign_up/register_screen.dart';
import 'package:spenza/ui/splash/opening_screen.dart';
import 'package:spenza/ui/webview_screen/webview_screen.dart';

import '../ui/my_store/my_store.dart';
import '../ui/receipts/upload_receipt_screen.dart';
import '../ui/splash/splash_screen.dart';
import 'app_router.dart';

final initialLocationProvider =
    StateProvider.autoDispose<String>((ref) => RouteManager.splashScreen);

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  final initialLocation = ref.watch(initialLocationProvider);

  /// For Bottom Navigation if required
  final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey(debugLabel: 'root');
  final GlobalKey<NavigatorState> _homeShellNavigator =
      GlobalKey(debugLabel: 'home');
  final GlobalKey<NavigatorState> _myListShellNavigator =
      GlobalKey(debugLabel: 'my_list');
  final GlobalKey<NavigatorState> _receiptsShellNavigator =
      GlobalKey(debugLabel: 'receipts');
  final GlobalKey<NavigatorState> _settingsShellNavigator =
      GlobalKey(debugLabel: 'settings');

  final router = GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigator,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigator,
        builder: (context, state, navigationShell) {
          return DashboardScreen(
            key: state.pageKey,
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeShellNavigator,
            routes: [
              GoRoute(
                name: RouteManager.homeScreen,
                path: RouteManager.homeScreen,
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
            navigatorKey: _myListShellNavigator,
            routes: [
              GoRoute(
                name: RouteManager.myListScreenBottomPath,
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
            navigatorKey: _receiptsShellNavigator,
            routes: [
              GoRoute(
                name: RouteManager.receiptListScreenBottomPath,
                path: "/shell/receipts",
                pageBuilder: (context, state) {
                  final String path = state.queryParameters['list_ref'] ?? "";
                  print("Shell Route Path Called == $path");
                  return NoTransitionPage(
                    child:
                        DisplayReceiptScreen(key: ValueKey(path), path: path),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsShellNavigator,
            routes: [
              GoRoute(
                name: RouteManager.settingsScreenBottomPath,
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
        name: RouteManager.splashScreen,
        path: RouteManager.splashScreen,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.openingScreen,
        path: RouteManager.openingScreen,
        builder: (context, state) {
          return OpeningScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.registerScreen,
        path: RouteManager.registerScreen,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.loginScreen,
        path: RouteManager.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.locationScreen,
        path: RouteManager.locationScreen,
        builder: (context, state) {
          /// Once Login or Register redirects to here.
          return const LocationScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.favouriteScreen,
        path: RouteManager.favouriteScreen,
        builder: (context, state) {
          /// Checks whether it's first time login or register when coming from location screen.
          return FavouriteStoreScreen(null);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.myListDetailScreen,
        path: RouteManager.myListDetailScreen,
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
        name: RouteManager.preLoadedListDetailScreen,
        path: RouteManager.preLoadedListDetailScreen,
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
        name: RouteManager.addProductScreen,
        path: RouteManager.addProductScreen,
        builder: (context, state) {
          final String query = state.queryParameters['query'] ?? "";
          return AddProductScreen(query: query);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.storeRankingScreen,
        path: RouteManager.storeRankingScreen,
        builder: (context, state) {
          return MatchingStoreScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.selectedStoreScreen,
        path: RouteManager.selectedStoreScreen,
        builder: (context, state) {
          return SelectedStoreScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.addNewList,
        path: RouteManager.addNewList,
        builder: (context, state) {
          return NewMyList();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.editListScreen,
        path: RouteManager.editListScreen,
        builder: (context, state) {
          return EditListScreen();
        },
      ),
      GoRoute(
        name: RouteManager.storesScreen,
        path: RouteManager.storesScreen,
        parentNavigatorKey: _rootNavigator,
        builder: (context, state) {
          return AllStoresScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.myStoreProductScreen,
        path: RouteManager.myStoreProductScreen,
        builder: (context, state) {
          final String storeId = state.queryParameters['store_id'] ?? "";
          final String logo = state.queryParameters['logo'] ?? "";
          final String? listId = state.queryParameters['list_id'];

          return MyStoreProduct(storeId: storeId, logo: logo, listId: listId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.settingScreen,
        path: RouteManager.settingScreen,
        builder: (context, state) {
          return SettingScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.profileScreen,
        path: RouteManager.profileScreen,
        builder: (context, state) {
          return ProfileScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.uploadReceiptScreen,
        path: RouteManager.uploadReceiptScreen,
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
        name: RouteManager.displayReceiptScreen,
        path: RouteManager.displayReceiptScreen,
        builder: (context, state) {
          final String path = state.queryParameters['list_ref'] ?? "";
          return DisplayReceiptScreen(
            // key: state.pageKey,
            path: path,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.preLoadedListScreen,
        path: RouteManager.preLoadedListScreen,
        builder: (context, state) {
          return PreloadedListScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.editProfileScreen,
        path: RouteManager.editProfileScreen,
        builder: (context, state) {
          return EditProfileInformation();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.myListScreen,
        path: RouteManager.myListScreen,
        builder: (context, state) {
          return MyListScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigator,
        name: RouteManager.webViewScreen,
        path: RouteManager.webViewScreen,
        builder: (context, state) {
          final String storeId = state.queryParameters['url'] ?? "";
          return WebViewScreen(url: storeId);
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);

  return router;
});
