import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';
import '../widgets/kite_tabs.dart';
import '../widgets/stock_tile.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KiteAppBar(title: 'Watchlist'),
            KiteTabs(
              tabs: const [
                KiteTab('Nifty 50'),
                KiteTab('Nifty 50 (Group...'),
                KiteTab('Major Indices', lock: true),
              ],
              selected: _selectedTab,
              onSelect: (i) => setState(() => _selectedTab = i),
              trailing: _layersButton(),
            ),
            _searchBand(),
            _newGroupRow(),
            Expanded(child: _listWithAccent()),
          ],
        ),
      ),
    );
  }

  Widget _layersButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 7.92, left: 1.32),
      child: SizedBox(
        width: 23.76,
        height: 23.76,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 23.76,
              height: 23.76,
              decoration: const BoxDecoration(
                  color: AppTheme.layersBtn, shape: BoxShape.circle),
              child: const Icon(Icons.layers_outlined,
                  color: AppTheme.blue, size: 13.2),
            ),
            Positioned(
              right: 0.66,
              top: 0.66,
              child: Container(
                width: 9.9,
                height: 9.9,
                decoration:
                    const BoxDecoration(color: AppTheme.blue, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 7.26),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search card floating over the grey band
  Widget _searchBand() {
    return Container(
      color: AppTheme.topSection,
      padding: const EdgeInsets.fromLTRB(7.92, 3.96, 7.92, 9.24),
      child: Material(
        elevation: 1.5,
        borderRadius: BorderRadius.circular(5.28),
        shadowColor: Colors.black.withOpacity(0.15),
        child: Container(
          height: 31.68,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(5.28),
          ),
          child: Row(
            children: [
              const SizedBox(width: 9.24),
              const Icon(Icons.search, color: AppTheme.searchHint, size: 15.18),
              const SizedBox(width: 6.6),
              Expanded(
                child: Text(
                  'Search & add',
                  style: GoogleFonts.inter(
                      fontSize: 10.23, color: AppTheme.searchHint),
                ),
              ),
              Text(
                '25/250',
                style: GoogleFonts.inter(
                    fontSize: 9.57, color: AppTheme.searchHint),
              ),
              const SizedBox(width: 7.92),
              Container(width: 0.66, height: 15.84, color: AppTheme.topSection),
              const SizedBox(width: 3.96),
              RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune,
                      color: AppTheme.textPrimary, size: 14.52),
                  splashRadius: 13.2,
                ),
              ),
              const SizedBox(width: 1.32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newGroupRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 6.6, 11.88, 6.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.add, size: 13.2, color: AppTheme.blue),
          const SizedBox(width: 2.64),
          Text(
            'New group',
            style: GoogleFonts.inter(
                fontSize: 10.56, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
        ],
      ),
    );
  }

  // Blue left accent + Default header + rows, all in one scroll
  Widget _listWithAccent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(width: 1.98, color: AppTheme.blue),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.56, 6.6, 10.56, 6.6),
                child: Row(
                  children: [
                    Text(
                      'Default ',
                      style: GoogleFonts.inter(
                          fontSize: 9.9,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary),
                    ),
                    Text(
                      '(25)',
                      style: GoogleFonts.inter(
                          fontSize: 9.9,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondary),
                    ),
                    const Spacer(),
                    const Icon(Icons.add, size: 15.18, color: AppTheme.textPrimary),
                    const SizedBox(width: 11.88),
                    const Icon(Icons.crop_free, size: 11.88, color: AppTheme.textPrimary),
                  ],
                ),
              ),
              const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
              for (int i = 0; i < dummyStocks.length; i++) ...[
                StockTile(stock: dummyStocks[i]),
                const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
