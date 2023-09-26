import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/di/app_providers.dart';

final languageProvider = StateProvider<String>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return sharedPrefs.getString('selectedLanguage') ?? 'en';
});




