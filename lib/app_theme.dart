import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // --- Cores Light ---
  static const Color _primaryLight = Color(0xFFB71C1C);
  static const Color _onPrimaryLight = Color(0xFFFFFFFF);
  static const Color _backgroundLight = Color(0xFFFFF4E6);
  static const Color _onBackgroundLight = Color(0xFF7A0000);
  static const Color _onSurfaceLight = Color(0xFF3A0000);

  // --- Cores Dark ---
  static const Color _primaryDark = Color(0xFFFFC107);
  static const Color _onPrimaryDark = Color(0xFF2A0000);
  static const Color _backgroundDark = Color(0xFF0D0B0B);
  static const Color _onBackgroundDark = Color(0xFFFFE082);
  static const Color _onSurfaceDark = Color(0xFFCFD8DC);

  // --- ColorScheme Light ---
  static const ColorScheme lightColors = ColorScheme(
    brightness: Brightness.light,
    primary: _primaryLight,
    onPrimary: _onPrimaryLight,
    secondary: _primaryLight,
    onSecondary: _onPrimaryLight,
    error: Color(0xFFB00020), // Substituído Colors.red por const Color
    onError: Colors.white,
    surface: _backgroundLight,
    onSurface: _onSurfaceLight,
    // Nota: background e onBackground são herdados de surface no M3
  );

  // --- ColorScheme Dark ---
  static const ColorScheme darkColors = ColorScheme(
    brightness: Brightness.dark,
    primary: _primaryDark,
    onPrimary: _onPrimaryDark,
    secondary: _primaryDark,
    onSecondary: _onPrimaryDark,
    error: Color(0xFFCF6679), // Substituído Colors.redAccent por const Color
    onError: Colors.black,
    surface: _backgroundDark,
    onSurface: _onSurfaceDark,
  );

  // --- Temas ---
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: lightColors,
        scaffoldBackgroundColor: _backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryLight,
          foregroundColor: _onPrimaryLight,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: darkColors,
        scaffoldBackgroundColor: _backgroundDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: _backgroundDark,
          foregroundColor: _primaryDark,
        ),
      );
}