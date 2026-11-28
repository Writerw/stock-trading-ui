import 'package:flutter/material.dart';
import '../theme/kite_text.dart';
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
              padding: const EdgeInsets.fromLTRB(10.56, 1.32, 10.56, 10.56),
              child: Row(
                children: [
                  Text(
                    'Demo User',
                    style: inter(
                        fontSize: 13.2, color: AppTheme.textSecondary),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none,
                      size: 18.48, color: AppTheme.textPrimary),
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
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        height: 34.32,
                        child: Container(color: AppTheme.topSection),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.24),
                        child: _profileCard(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19.8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.56, 5.28, 10.56, 9.24),
                    child: Text(
                      'Account',
                      style: inter(
                          fontSize: 11.22,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary),
                    ),
                  ),
                  const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
                  _row('Funds', Icons.currency_rupee),
                  _row('Mandates', Icons.event_repeat),
                  _row('App Code', Icons.lock_open_outlined),
                  _row('Profile', Icons.person_outline),
                  _row('Settings', Icons.settings_outlined),
                  _row('Connected apps', Icons.view_in_ar_outlined),
                  _row('Logout', Icons.logout),
                  const SizedBox(height: 15.84),
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
      borderRadius: BorderRadius.circular(6.6),
      shadowColor: Colors.black.withOpacity(0.12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.6),
        child: Column(
          children: [
            Container(
              color: AppTheme.surface,
              padding: const EdgeInsets.fromLTRB(13.2, 17.16, 13.2, 17.16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DEMOUSER',
                          style: inter(
                              fontSize: 17.16, color: AppTheme.textPrimary),
                        ),
                        const SizedBox(height: 5.28),
                        Text(
                          'demo@zerodha.com',
                          style: inter(
                              fontSize: 9.9, color: AppTheme.metaGrey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60.72,
                    height: 60.72,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppTheme.chipBlueBg, shape: BoxShape.circle),
                    child: Text(
                      'DU',
                      style: inter(
                          fontSize: 19.8,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.avatarText),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppTheme.rowAltBg,
              padding: const EdgeInsets.fromLTRB(13.2, 10.56, 13.2, 10.56),
              child: Row(
                children: [
                  Text(
                    'Privacy mode',
                    style: inter(
                        fontSize: 11.22,
                        fontWeight: FontWeight.w500,
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
      width: 34.32,
      height: 19.8,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E8),
        borderRadius: BorderRadius.circular(9.9),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(1.98),
          child: Container(
            width: 15.84,
            height: 15.84,
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
          padding: const EdgeInsets.fromLTRB(10.56, 12.54, 10.56, 12.54),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: inter(
                      fontSize: 11.22, color: AppTheme.textPrimary),
                ),
              ),
              Icon(icon, size: 15.84, color: AppTheme.metaGrey),
            ],
          ),
        ),
        const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
      ],
    );
  }
}
