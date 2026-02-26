import 'package:flutter/material.dart';
import 'features/login/components/auth.dart';
import 'features/shared/app_colors.dart';
import 'features/shared/helper.dart';
import 'features/shared/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager().themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          themeMode: mode,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColorsTheme.light.background,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColorsTheme.light.background,
              foregroundColor: AppColorsTheme.light.textPrimary,
              elevation: 0,
            ),
            extensions: const [AppColorsTheme.light],
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColorsTheme.dark.background,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColorsTheme.dark.background,
              foregroundColor: AppColorsTheme.dark.textPrimary,
              elevation: 0,
            ),
            extensions: const [AppColorsTheme.dark],
          ),
          home: const AuthScreen(),
        );
      },
    ),
  );
}
