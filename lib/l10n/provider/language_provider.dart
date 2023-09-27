import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class LocaleNotifier extends StateNotifier < Locale > {
  LocaleNotifier(): super(Locale('en')) {
    onAppStart();
  }

  void changeLanguage(SupportedLocale locale)  async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("language", locale.code );
      state = Locale(locale.code);
    } catch (error) {
      state = Locale('en');
    }
  }

  void onAppStart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locale = prefs.getLanguage();
      state = locale;
    } catch (error) {
      state = Locale('en');
    }
  }
}

final localeProvider = StateNotifierProvider < LocaleNotifier, Locale > ((ref) {
  return LocaleNotifier();
});




