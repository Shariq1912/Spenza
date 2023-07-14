import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class SpenzaApp extends ConsumerWidget {
  const SpenzaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderProvider);
    // print(Localizations.localeOf(context).languageCode);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        final l10n = AppLocalizations.of(context);
        return l10n!.appTitle;
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      /// If manually want to set locale
      // locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: RouteManager.router.routeInformationParser,
      routerDelegate: RouteManager.router.routerDelegate,
      routeInformationProvider: RouteManager.router.routeInformationProvider,
    );
  }
}
