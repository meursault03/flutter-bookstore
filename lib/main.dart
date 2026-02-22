import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'features/login/components/auth.dart';
import 'features/login/components/background.dart';
import 'features/shared/responsive_center.dart';

/// Enables mouse-drag scrolling on desktop so horizontal PageViews and
/// ListViews respond to click-and-drag (not just touch).
class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      scrollBehavior: _AppScrollBehavior(),
      home: const Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 15, 81, 250),
          Color.fromARGB(255, 0, 180, 238),
          child: SingleChildScrollView(
            child: ResponsiveCenter(child: AuthScreen()),
          ),
        ),
      ),
    ),
  );
}
