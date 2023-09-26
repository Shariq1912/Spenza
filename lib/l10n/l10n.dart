import 'dart:ui';

enum Language {
  english("en"),
  spanish("es");

  const Language(this.languageCode);

  final String languageCode;
}

class L10n {
  static final all = [
    Locale(Language.english.languageCode),
    Locale(Language.spanish.languageCode),
  ];
}
