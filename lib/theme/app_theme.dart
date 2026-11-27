import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Colors sampled directly from the Kite watchlist screenshot ───
  static const Color background = Color(0xFFFFFFFF);   // white screen
  static const Color surface = Color(0xFFFFFFFF);      // white surface / search card
  static const Color card = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFF0F0F2);      // faint row divider
  static const Color outline = Color(0xFF74777F);
  static const Color topSection = Color(0xFFEBECED);   // grey band behind tabs/search
  static const Color textPrimary = Color(0xFF424250);  // all dark text
  static const Color textSecondary = Color(0xFF9B9BAF); // secondary grey
  static const Color indicesGrey = Color(0xFFB8B8C6);  // "INDICES" label
  static const Color searchHint = Color(0xFF9B9BAF);   // placeholder grey
  static const Color blue = Color(0xFF4184F3);         // tabs / links / selected
  static const Color green = Color(0xFF4CAF50);         // up price
  static const Color red = Color(0xFFDF514C);           // down price
  static const Color exitDemo = Color(0xFFF5BD00);      // yellow pill
  static const Color layersBtn = Color(0xFFD6DFED);     // layers button bg

  // ─── Orders / IPO / Account tokens (sampled from screenshots) ───
  static const Color chipRedBg = Color(0xFFFBE9E9);     // SELL chip bg
  static const Color chipBlueBg = Color(0xFFE7F0FD);    // BUY chip bg / avatar bg
  static const Color chipGreyBg = Color(0xFFF0F0F1);    // OPEN / CLOSED chip bg
  static const Color badgeActive = Color(0xFF87AFF1);   // active tab count badge
  static const Color badgeInactive = Color(0xFF888891); // inactive tab count badge
  static const Color metaGrey = Color(0xFF9B9BAF);      // tags / company / list icons
  static const Color rowAltBg = Color(0xFFFAFAFB);      // privacy-mode strip
  static const Color avatarText = Color(0xFF9FC1F9);    // "DU" initials

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
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textPrimary),
        bodySmall: GoogleFonts.inter(fontSize: 12, color: textSecondary),
        titleMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
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
