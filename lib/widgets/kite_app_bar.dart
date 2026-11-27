import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../version.dart';

/// Title row shared by every screen: big title + yellow "Exit demo" pill +
/// down chevron, on the grey top band.
class KiteAppBar extends StatelessWidget {
  final String title;
  const KiteAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.topSection,
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 10),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: AppTheme.exitDemo,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 16, color: AppTheme.textPrimary),
                const SizedBox(width: 6),
                Text(
                  'Exit demo $kBuildVersion',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, size: 28, color: AppTheme.textPrimary),
        ],
      ),
    );
  }
}
