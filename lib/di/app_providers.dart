import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_providers.g.dart';

@riverpod
class LocaleProvider extends _$LocaleProvider {
  @override
  Locale build() {
    return const Locale('en');
  }

  void changeLocale(String code) {
    state = Locale(code);
  }
}

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
