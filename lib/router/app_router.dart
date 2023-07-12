import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/login/login_route.dart';
import 'package:spenza/ui/sign_up/sign_up_route.dart';
import 'package:spenza/ui/splash/splash_route.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

/// For Bottom Navigation if required
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class RouteManager {
  static const String splashScreen = '/loginScreen';

  static const String loginScreen = '/';
  static const String registerScreen = '/registerScreen';
  static const String dashboardScreen = '/dashboard';

  /// The route configuration.
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    routes: [
      GoRoute(
        name: splashScreen,
        path: splashScreen,
        builder: (context, state) {
          return const SplashRoute();
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
          return const LoginRoute();
        },
      ),

    ],
    redirect: (context, state) async {
      return null;
    },
  );
}
