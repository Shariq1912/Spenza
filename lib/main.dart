
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spenza/router/app_router.dart';
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      routeInformationParser: RouteManager.router.routeInformationParser,
      routerDelegate: RouteManager.router.routerDelegate,
      routeInformationProvider: RouteManager.router.routeInformationProvider,
    );
  }
}
