import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Constrói o [ThemeData] com [AppColorsTheme.light] como extensao.
ThemeData buildLightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColorsTheme.light.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsTheme.light.background,
      foregroundColor: AppColorsTheme.light.textPrimary,
      elevation: 0,
    ),
    extensions: const [AppColorsTheme.light],
  );
}

/// Faz a versão dark [ThemeData] com [AppColorsTheme.dark] como extensão.
ThemeData buildDarkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColorsTheme.dark.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsTheme.dark.background,
      foregroundColor: AppColorsTheme.dark.textPrimary,
      elevation: 0,
    ),
    extensions: const [AppColorsTheme.dark],
  );
}