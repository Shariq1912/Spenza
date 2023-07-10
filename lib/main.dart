
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/login/login_route.dart';
import 'package:spenza/ui/sign_up/sign_up_route.dart';
import 'package:spenza/ui/splash/splash_route.dart';

import 'dependency_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
  final _router = GoRouter(routes: [
    GoRoute(
        name: "splash",
        path: "/",
        builder: (context, state) {
          return  SplashRoute();
        }),
    GoRoute(
        name: "signUp",
        path: "/signUp",
        builder: (context, state) {
          return  SignUpScreen();
        }),
    GoRoute(
        name: "login",
        path: "/login",
        builder: (context, state) {
          return  LoginRoute();
        }),

  ]);
}
