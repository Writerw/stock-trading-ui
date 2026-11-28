import 'package:flutter/material.dart';
import '../theme/kite_text.dart';
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(9.24)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _toolbar(),
                    const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          for (final ipo in ongoingIpos) ...[
                            _ipoRow(ipo),
                            const Divider(
                                height: 0.33, thickness: 0.33, color: AppTheme.divider),
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
      padding: const EdgeInsets.fromLTRB(10.56, 7.26, 7.92, 7.26),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 16.5),
          const SizedBox(width: 15.84),
          const RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.tune, color: AppTheme.blue, size: 15.18),
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
        margin: const EdgeInsets.only(left: 2.64),
        padding: const EdgeInsets.symmetric(horizontal: 9.24, vertical: 5.94),
        decoration: BoxDecoration(
          color: sel ? AppTheme.chipGreyBg : Colors.transparent,
          borderRadius: BorderRadius.circular(3.96),
        ),
        child: Text(
          label,
          style: inter(
            fontSize: 10.23,
            fontWeight: sel ? FontWeight.w500 : FontWeight.w400,
            color: sel ? AppTheme.blue : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _ipoRow(IpoItem ipo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 11.22, 10.56, 11.22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ipo.company,
            style: inter(fontSize: 9.57, color: AppTheme.metaGrey),
          ),
          const SizedBox(height: 6.6),
          Row(
            children: [
              Text(
                ipo.symbol,
                style: inter(fontSize: 11.22, color: AppTheme.textPrimary),
              ),
              if (ipo.sme) ...[
                const SizedBox(width: 6.6),
                Text(
                  'SME',
                  style: inter(
                      fontSize: 8.25,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.blue),
                ),
              ],
              const Spacer(),
              if (ipo.openForApply)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.52, vertical: 5.94),
                  decoration: BoxDecoration(
                      color: AppTheme.blue, borderRadius: BorderRadius.circular(2.64)),
                  child: Text(
                    'Apply',
                    style: inter(
                        fontSize: 10.23,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.56, vertical: 5.94),
                  decoration: BoxDecoration(
                      color: AppTheme.chipGreyBg,
                      borderRadius: BorderRadius.circular(2.64)),
                  child: Text(
                    'CLOSED',
                    style: inter(
                        fontSize: 8.91,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6.6),
          Row(
            children: [
              Expanded(
                child: Text(
                  ipo.priceBand,
                  style: inter(fontSize: 9.9, color: AppTheme.textPrimary),
                ),
              ),
              Text(
                ipo.dates,
                style: inter(fontSize: 9.9, color: AppTheme.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _viewUpcoming() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 13.2, 10.56, 13.2),
      child: Row(
        children: [
          Text(
            'View upcoming IPOs',
            style: inter(
                fontSize: 10.89, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
          const SizedBox(width: 6.6),
          const Icon(Icons.arrow_forward, size: 12.54, color: AppTheme.blue),
        ],
      ),
    );
  }
}
