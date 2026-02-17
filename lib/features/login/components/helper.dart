import 'package:flutter/material.dart';

/// Utilitários num geral.
///
/// Não é um widget — é uma classe helper que fornece métodos estáticos
/// para obter informações da tela de forma segura (respeitando safe areas).
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
}
