import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color background = Color(0xFFF9FAFB); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF111827); // Slate 900
  static const Color textSecondary = Color(0xFF6B7280); // Slate 500
  static const Color border = Color(0xFFE5E7EB); // Slate 200

  // Status Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successBg = Color(0xFFECFDF5); // Emerald 50
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningBg = Color(0xFFFFFBEB); // Amber 50
  static const Color danger = Color(0xFFEF4444); // Red 500
  static const Color dangerBg = Color(0xFFFEF2F2); // Red 50
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoBg = Color(0xFFEFF6FF); // Blue 50

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: primaryLight,
        background: background,
        surface: surface,
        error: danger,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: textMain,
        displayColor: textMain,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        iconTheme: IconThemeData(color: textSecondary),
        titleTextStyle: TextStyle(
          color: textMain,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
