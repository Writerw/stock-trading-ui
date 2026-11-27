import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const KiteAppBar(title: 'Account'),
            // "Demo User" + bell, still on the grey band
            Container(
              color: AppTheme.topSection,
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
              child: Row(
                children: [
                  Text(
                    'Demo User',
                    style: GoogleFonts.inter(
                        fontSize: 20, color: AppTheme.textSecondary),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none,
                      size: 28, color: AppTheme.textPrimary),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // profile card, floating across the grey/white boundary
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 52,
                        child: Container(color: AppTheme.topSection),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: _profileCard(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                    child: Text(
                      'Account',
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary),
                    ),
                  ),
                  const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
                  _row('Funds', Icons.currency_rupee),
                  _row('Mandates', Icons.event_repeat),
                  _row('App Code', Icons.lock_open_outlined),
                  _row('Profile', Icons.person_outline),
                  _row('Settings', Icons.settings_outlined),
                  _row('Connected apps', Icons.view_in_ar_outlined),
                  _row('Logout', Icons.logout),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCard() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.black.withOpacity(0.12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.fromLTRB(20, 26, 20, 26),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DEMOUSER',
                          style: GoogleFonts.inter(
                              fontSize: 26, color: AppTheme.textPrimary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'demo@zerodha.com',
                          style: GoogleFonts.inter(
                              fontSize: 15, color: AppTheme.metaGrey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 92,
                    height: 92,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppTheme.chipBlueBg, shape: BoxShape.circle),
                    child: Text(
                      'DU',
                      style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.avatarText),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppTheme.rowAltBg,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  Text(
                    'Privacy mode',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary),
                  ),
                  const Spacer(),
                  _toggleOff(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleOff() {
    return Container(
      width: 52,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, IconData icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 19, 16, 19),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                      fontSize: 17, color: AppTheme.textPrimary),
                ),
              ),
              Icon(icon, size: 24, color: AppTheme.metaGrey),
            ],
          ),
        ),
        const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
      ],
    );
  }
}
