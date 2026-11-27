import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Light theme colors (ported from JetKite design system) ───
  static const Color background = Color(0xFFF6FEFF);   // md_theme_light_background
  static const Color surface = Color(0xFFFFFFFF);      // white surface / search card
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE1E2EC);      // surfaceVariant
  static const Color outline = Color(0xFF74777F);      // md_theme_light_outline
  static const Color topSection = Color(0xFFECECEC);   // colorTopSectionBackgroundLight
  static const Color textPrimary = Color(0xFF001F24);  // onBackground
  static const Color textSecondary = Color(0xFF44474F); // onSurfaceVariant
  static const Color searchHint = Color(0xFF8A9499);   // readable placeholder grey
  static const Color blue = Color(0xFF4184F3);         // md_theme_light_primary
  static const Color green = Color(0xFF4D9B59);        // colorGreen
  static const Color red = Color(0xFFE87477);          // colorRed

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
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: blue,
        unselectedItemColor: textSecondary,
      ),
      colorScheme: const ColorScheme.light(
        primary: blue,
        surface: surface,
      ),
    );
  }
}
