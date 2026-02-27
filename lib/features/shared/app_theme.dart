import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Builds the light [ThemeData] with [AppColorsTheme.light] as an extension.
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

/// Builds the dark [ThemeData] with [AppColorsTheme.dark] as an extension.
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