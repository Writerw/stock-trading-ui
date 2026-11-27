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
      padding: const EdgeInsets.only(right: 12, left: 2),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                  color: AppTheme.layersBtn, shape: BoxShape.circle),
              child: const Icon(Icons.layers_outlined,
                  color: AppTheme.blue, size: 20),
            ),
            Positioned(
              right: 1,
              top: 1,
              child: Container(
                width: 15,
                height: 15,
                decoration:
                    const BoxDecoration(color: AppTheme.blue, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 11),
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
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 14),
      child: Material(
        elevation: 1.5,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black.withOpacity(0.15),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              const Icon(Icons.search, color: AppTheme.searchHint, size: 23),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Search & add',
                  style: GoogleFonts.inter(
                      fontSize: 15.5, color: AppTheme.searchHint),
                ),
              ),
              Text(
                '25/250',
                style: GoogleFonts.inter(
                    fontSize: 14.5, color: AppTheme.searchHint),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 24, color: AppTheme.topSection),
              const SizedBox(width: 6),
              RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune,
                      color: AppTheme.textPrimary, size: 22),
                  splashRadius: 20,
                ),
              ),
              const SizedBox(width: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newGroupRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 18, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.add, size: 20, color: AppTheme.blue),
          const SizedBox(width: 4),
          Text(
            'New group',
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.blue),
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
        Container(width: 3, color: AppTheme.blue),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  children: [
                    Text(
                      'Default ',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary),
                    ),
                    Text(
                      '(25)',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondary),
                    ),
                    const Spacer(),
                    const Icon(Icons.add, size: 23, color: AppTheme.textPrimary),
                    const SizedBox(width: 18),
                    const Icon(Icons.crop_free, size: 18, color: AppTheme.textPrimary),
                  ],
                ),
              ),
              const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
              for (int i = 0; i < dummyStocks.length; i++) ...[
                StockTile(stock: dummyStocks[i]),
                const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
