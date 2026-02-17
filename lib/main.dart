import 'package:flutter/material.dart';
import 'features/login/components/auth.dart';
import 'features/login/components/background.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 15, 81, 250),
          Color.fromARGB(255, 0, 180, 238),
          child: SingleChildScrollView(child: AuthScreen()),
        ),
      ),
    ),
  );
}
