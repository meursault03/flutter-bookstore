import 'package:flutter/material.dart';

/// Singleton que gerencia o tema do aplicativo via ValueNotifier.
class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.light);

  bool get isDark => themeMode.value == ThemeMode.dark;

  void toggleTheme() {
    themeMode.value =
        isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
