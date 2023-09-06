import 'dart:ui';

import 'package:flutter/material.dart';

class ColorUtils {
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorPrimary = Color(0xFF0DA9E6);
  static const Color colorSecondary = Color(0xFF94d500);
  static const Color colorError = Color(0xFFff5963);
  static const Color colorSurface = Color(0xFFe5e7e8);

  static const Color colorPrimaryText = Color(0xFF323e48);
  static const Color colorSecondaryText = Color(0xFF7b868c);

  static const Color lightGrey = Color(0xFFf8f8f8);
  static const Color dashbaordTvColor = Color(0xFF444444);

  static MaterialColor convertColorIntoMaterialColor(Color color) {
    Map<int, Color> colorMap = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    };

    return MaterialColor(color.value, colorMap);
  }
}
