import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 106, 239, 99);
  static const Color primarioClaro = Color.fromARGB(255, 108, 193, 106);
  static const Color acento = Color(0xFF88B04B);
  static const Color textoPrincipal = Color(0xFFFAFAFA);
  static const Color textoSecundario = Color(0xFF8B7E7D);
  static const Color fondo = Color(0xFFF8F8F8);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

ThemeData buildviveroTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: AppColors.textoPrincipal,
      ),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textoSecundario),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
