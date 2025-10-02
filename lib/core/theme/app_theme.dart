import 'package:flutter/material.dart';

/// Centralized theme configuration for the application.
class AppTheme {
  AppTheme._();

  /// Seed color used to generate the color scheme.
  static const Color seed = Color(0xFFFFB202);

  /// Home hero animation duration.
  static const Duration homeHeroDuration = Duration(milliseconds: 1200);

  /// Home hero initial diameter.
  static const double homeHeroInitialSize = 2000;

  /// Home hero final diameter.
  static const double homeHeroFinalSize = 1200;

  /// Delay before showing the home content.
  static const Duration homeContentDelay = Duration(milliseconds: 1000);

  /// Duration for the welcome message fade out.
  static const Duration homeWelcomeDuration = Duration(milliseconds: 600);

  /// Duration for the content fade out.
  static const Duration homeContentDuration = Duration(milliseconds: 600);

  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: seed);
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.surface,
      useMaterial3: true,
      textTheme: const TextTheme().apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.cardBackground,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }
}

/// Custom color palette derived from the seed color.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFB202);
  static const Color surface = Color(0xFFDFF8FA);
  static const Color cardBackground = Color(0xFFFAFAFA);
  static const Color border = Color(0xFFEEEEEE);
  static const Color textDark = Color(0xFF737373);
  static const Color textBlack = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF737373);
  static const Color grey = Color(0xFF828282);
  static const Color shadow = Color.fromARGB(255, 130, 130, 130);
}

