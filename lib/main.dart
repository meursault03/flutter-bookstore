import 'package:flutter/material.dart';
import 'features/login/components/auth.dart';
import 'features/shared/app_theme.dart';
import 'features/shared/helper.dart';
import 'features/shared/theme_manager.dart';
import 'services/session_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager().init();
  runApp(const BookstoreApp());
}

class BookstoreApp extends StatelessWidget {
  const BookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager().themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          themeMode: mode,
          theme: buildLightTheme(),
          darkTheme: buildDarkTheme(),
          home: const AuthScreen(),
        );
      },
    );
  }
}
