
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/router/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await inject();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: SpenzaApp(),
    ),
  );

}

class SpenzaApp extends StatelessWidget {
  const SpenzaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Spenza App',
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
