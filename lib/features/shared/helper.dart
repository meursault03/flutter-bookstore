import 'dart:ui';

import 'package:flutter/material.dart';

/// Utilitários de tela: retorna altura e largura úteis respeitando safe areas.
class ScreenHelper {
  static double getUsableHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeTop = MediaQuery.of(context).padding.top;
    final safeBottom = MediaQuery.of(context).padding.bottom;
    return screenHeight - safeTop - safeBottom;
  }

  static double getUsableWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final safeLeft = MediaQuery.of(context).padding.left;
    final safeRight = MediaQuery.of(context).padding.right;
    return screenWidth - safeLeft - safeRight;
  }

  static bool isWideScreen(BuildContext context) =>
      MediaQuery.of(context).size.width > 600;
}

/// Permite scrollar na vertical em múltiplos dispositivos
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}
