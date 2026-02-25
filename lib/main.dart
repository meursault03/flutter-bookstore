import 'package:flutter/material.dart';
import 'features/login/components/auth.dart';
import 'features/shared/helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      home: const AuthScreen(),
    ),
  );
}
