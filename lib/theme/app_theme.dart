import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Light / White theme colors (Kite style) ───
  static const Color background = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFE8E8E8);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color blue = Color(0xFF2D77FF);
  static const Color green = Color(0xFF29A745);
  static const Color red = Color(0xFFF6465D);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: blue,
      scaffoldBackgroundColor: background,
      cardColor: card,
      dividerColor: divider,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.roboto(fontSize: 16, color: textPrimary),
        bodyMedium: GoogleFonts.roboto(fontSize: 14, color: textPrimary),
        bodySmall: GoogleFonts.roboto(fontSize: 12, color: textSecondary),
        titleMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      ),
      cardTheme: const CardTheme(
        elevation: 0,
        color: card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: background,
        selectedItemColor: blue,
        unselectedItemColor: textSecondary,
      ),
      colorScheme: const ColorScheme.light(
        primary: blue,
        surface: card,
      ),
    );
  }
}
