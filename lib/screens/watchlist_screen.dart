import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/stock_tile.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = const ['Nifty 50', 'Nifty 50 (Group...', 'Major Indices'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleRow(),
            _tabRow(),
            _searchBand(),
            _newGroupRow(),
            Expanded(child: _listWithAccent()),
          ],
        ),
      ),
    );
  }

  // ─── 1. Title: "Watchlist"  [Exit demo]            v ───
  Widget _titleRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 10),
      child: Row(
        children: [
          Text(
            'Watchlist',
            style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          // yellow "Exit demo" pill
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
                  'Exit demo',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 28, color: AppTheme.textPrimary),
        ],
      ),
    );
  }

  // ─── 2. Tabs (grey band) + layers button ───
  Widget _tabRow() {
    return Container(
      color: AppTheme.topSection,
      height: 46,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: _tabs.length,
              itemBuilder: (context, i) => _tab(_tabs[i], i, hasLock: i == 2),
            ),
          ),
          // layers + button
          Padding(
            padding: const EdgeInsets.only(right: 14, left: 6),
            child: SizedBox(
              width: 38,
              height: 38,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(color: AppTheme.layersBtn, shape: BoxShape.circle),
                    child: const Icon(Icons.layers_outlined, color: AppTheme.blue, size: 21),
                  ),
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(color: AppTheme.blue, shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, int i, {bool hasLock = false}) {
    final sel = _selectedTab == i;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = i),
      child: Container(
        color: AppTheme.topSection,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: sel ? FontWeight.w600 : FontWeight.w400,
                      color: sel ? AppTheme.blue : AppTheme.textPrimary,
                    ),
                  ),
                  if (hasLock) ...[
                    const SizedBox(width: 5),
                    const Icon(Icons.lock_outline, size: 14, color: AppTheme.textPrimary),
                  ],
                ],
              ),
            ),
            Container(
              height: 2.5,
              width: double.infinity,
              color: sel ? AppTheme.blue : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  // ─── 3. Search card floating over grey band ───
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
                  style: GoogleFonts.roboto(fontSize: 15.5, color: AppTheme.searchHint),
                ),
              ),
              Text(
                '25/250',
                style: GoogleFonts.roboto(fontSize: 14.5, color: AppTheme.searchHint),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 24, color: AppTheme.topSection),
              const SizedBox(width: 6),
              RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune, color: AppTheme.textPrimary, size: 22),
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

  // ─── 4. "+ New group" (right-aligned, blue) ───
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
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
        ],
      ),
    );
  }

  // ─── 5+6. Blue left accent + Default header + list ───
  Widget _listWithAccent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(width: 3, color: AppTheme.blue),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Default (25) header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  children: [
                    Text(
                      'Default ',
                      style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                    ),
                    Text(
                      '(25)',
                      style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.textSecondary),
                    ),
                    const Spacer(),
                    const Icon(Icons.add, size: 23, color: AppTheme.textPrimary),
                    const SizedBox(width: 18),
                    const Icon(Icons.open_in_full, size: 18, color: AppTheme.textPrimary),
                  ],
                ),
              ),
              Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: dummyStocks.length,
                  separatorBuilder: (_, __) => Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
                  itemBuilder: (context, i) => StockTile(stock: dummyStocks[i]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
