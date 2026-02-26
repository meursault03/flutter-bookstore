import 'package:flutter/material.dart';

/// Cores e constantes visuais centralizadas do app.
/// Extraídas dos componentes de login para manter consistência global.
class AppColors {
  AppColors._();

  // Primárias (gradiente) — brand colors, estáticas
  static const Color primaryBlue = Color(0xFF0F51FA);
  static const Color primaryCyan = Color(0xFF00B4EE);

  // Feedback — estática
  static const Color badgeRed = Color(0xFFE53935);

  // Gradiente padrão — estático
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryCyan],
  );

  // Espaçamentos padrão — estáticos
  static const double paddingPage = 24.0;
  static const double paddingCard = 16.0;
  static const double radiusCard = 12.0;
  static const double radiusButton = 35.0;

  // Legacy static constants (mantidos para compatibilidade com auth screens)
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF757575);
  static const Color textSubtle = Colors.black54;
  static const Color divider = Color(0xFFEEEEEE);
  static const Color surfaceLight = Color(0xFFEEEEEE);
  static const Color iconInactive = Colors.grey;

  /// Acessor adaptivo via ThemeExtension.
  static AppColorsTheme of(BuildContext context) {
    return Theme.of(context).extension<AppColorsTheme>()!;
  }
}

/// ThemeExtension com cores adaptivas para light/dark mode.
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textSubtle;
  final Color divider;
  final Color surfaceLight;
  final Color iconInactive;
  final Color cardShadow;

  const AppColorsTheme({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textSubtle,
    required this.divider,
    required this.surfaceLight,
    required this.iconInactive,
    required this.cardShadow,
  });

  static const light = AppColorsTheme(
    background: Colors.white,
    surface: Colors.white,
    textPrimary: Colors.black,
    textSecondary: Color(0xFF757575),
    textSubtle: Colors.black54,
    divider: Color(0xFFEEEEEE),
    surfaceLight: Color(0xFFEEEEEE),
    iconInactive: Colors.grey,
    cardShadow: Color(0x14000000),
  );

  static const dark = AppColorsTheme(
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFE0E0E0),
    textSecondary: Color(0xFF9E9E9E),
    textSubtle: Color(0xFFBDBDBD),
    divider: Color(0xFF2C2C2C),
    surfaceLight: Color(0xFF2C2C2C),
    iconInactive: Color(0xFF757575),
    cardShadow: Color(0x40000000),
  );

  @override
  AppColorsTheme copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textSubtle,
    Color? divider,
    Color? surfaceLight,
    Color? iconInactive,
    Color? cardShadow,
  }) {
    return AppColorsTheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textSubtle: textSubtle ?? this.textSubtle,
      divider: divider ?? this.divider,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      iconInactive: iconInactive ?? this.iconInactive,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  AppColorsTheme lerp(covariant AppColorsTheme? other, double t) {
    if (other == null) return this;
    return AppColorsTheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      surfaceLight: Color.lerp(surfaceLight, other.surfaceLight, t)!,
      iconInactive: Color.lerp(iconInactive, other.iconInactive, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
    );
  }
}
