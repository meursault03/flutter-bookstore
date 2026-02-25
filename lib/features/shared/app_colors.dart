import 'package:flutter/material.dart';

/// Cores e constantes visuais centralizadas do app.
/// Extraídas dos componentes de login para manter consistência global.
class AppColors {
  AppColors._();

  // Primárias (gradiente)
  static const Color primaryBlue = Color(0xFF0F51FA);
  static const Color primaryCyan = Color(0xFF00B4EE);

  // Neutras
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF757575); // grey[600]
  static const Color textSubtle = Colors.black54;
  static const Color divider = Color(0xFFEEEEEE); // grey[200]
  static const Color surfaceLight = Color(0xFFEEEEEE); // grey[200]
  static const Color iconInactive = Colors.grey;

  // Feedback
  static const Color badgeRed = Color(0xFFE53935);

  // Gradiente padrão
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryCyan],
  );

  // Espaçamentos padrão
  static const double paddingPage = 24.0;
  static const double paddingCard = 16.0;
  static const double radiusCard = 12.0;
  static const double radiusButton = 35.0;
}
