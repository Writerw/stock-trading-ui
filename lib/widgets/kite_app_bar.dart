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
      padding: const EdgeInsets.fromLTRB(10.56, 6.6, 9.24, 6.6),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 7.92),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.58, vertical: 4.62),
            decoration: BoxDecoration(
              color: AppTheme.exitDemo,
              borderRadius: BorderRadius.circular(13.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 10.56, color: AppTheme.textPrimary),
                const SizedBox(width: 3.96),
                Text(
                  'Exit demo $kBuildVersion',
                  style: GoogleFonts.inter(
                    fontSize: 9.24,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, size: 18.48, color: AppTheme.textPrimary),
        ],
      ),
    );
  }
}
