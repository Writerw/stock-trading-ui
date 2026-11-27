import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/ipo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';
import '../widgets/kite_tabs.dart';

class IpoScreen extends StatefulWidget {
  const IpoScreen({super.key});

  @override
  State<IpoScreen> createState() => _IpoScreenState();
}

class _IpoScreenState extends State<IpoScreen> {
  int _tab = 0;
  int _seg = 0; // Ongoing / Applied / Upcoming

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.topSection,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const KiteAppBar(title: 'IPO & Bids'),
            KiteTabs(
              tabs: const [
                KiteTab('IPO', badge: 1),
                KiteTab('Govt. securities'),
                KiteTab('Auctions'),
                KiteTab('Corporate actions'),
              ],
              selected: _tab,
              onSelect: (i) => setState(() => _tab = i),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _toolbar(),
                    const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          for (final ipo in ongoingIpos) ...[
                            _ipoRow(ipo),
                            const Divider(
                                height: 0.5, thickness: 0.5, color: AppTheme.divider),
                          ],
                          _viewUpcoming(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 11, 12, 11),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 25),
          const SizedBox(width: 24),
          const RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.tune, color: AppTheme.blue, size: 23),
          ),
          const Spacer(),
          _seg0('Ongoing', 0),
          _seg0('Applied', 1),
          _seg0('Upcoming', 2),
        ],
      ),
    );
  }

  Widget _seg0(String label, int i) {
    final sel = _seg == i;
    return GestureDetector(
      onTap: () => setState(() => _seg = i),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: sel ? AppTheme.chipGreyBg : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15.5,
            fontWeight: sel ? FontWeight.w500 : FontWeight.w400,
            color: sel ? AppTheme.blue : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _ipoRow(IpoItem ipo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ipo.company,
            style: GoogleFonts.inter(fontSize: 14.5, color: AppTheme.metaGrey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                ipo.symbol,
                style: GoogleFonts.inter(fontSize: 17, color: AppTheme.textPrimary),
              ),
              if (ipo.sme) ...[
                const SizedBox(width: 10),
                Text(
                  'SME',
                  style: GoogleFonts.inter(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.blue),
                ),
              ],
              const Spacer(),
              if (ipo.openForApply)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
                  decoration: BoxDecoration(
                      color: AppTheme.blue, borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    'Apply',
                    style: GoogleFonts.inter(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                      color: AppTheme.chipGreyBg,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    'CLOSED',
                    style: GoogleFonts.inter(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  ipo.priceBand,
                  style: GoogleFonts.inter(fontSize: 15, color: AppTheme.textPrimary),
                ),
              ),
              Text(
                ipo.dates,
                style: GoogleFonts.inter(fontSize: 15, color: AppTheme.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _viewUpcoming() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Row(
        children: [
          Text(
            'View upcoming IPOs',
            style: GoogleFonts.inter(
                fontSize: 16.5, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, size: 19, color: AppTheme.blue),
        ],
      ),
    );
  }
}
