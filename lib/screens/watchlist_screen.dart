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
  String _searchQuery = '';
  int _selectedTab = 0;

  List<Stock> get _filteredStocks {
    if (_searchQuery.isEmpty) return dummyStocks;
    return dummyStocks
        .where((s) =>
            s.symbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── TITLE ROW: "Watchlist" + down chevron ───
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Watchlist',
                    style: GoogleFonts.roboto(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 30,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ─── TAB ROW: Nifty 50 | Nifty 50 (Group... | Major Indices 🔒 | [+] ───
            SizedBox(
              height: 34,
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 16),
                      children: [
                        _buildTab('Nifty 50', 0, false),
                        _buildTab('Nifty 50 (Group...', 1, false),
                        _buildTab('Major Indices', 2, true),
                      ],
                    ),
                  ),
                  // Layered circle add button (Kite style)
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A3A5C),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.layers_rounded,
                              color: AppTheme.blue,
                              size: 20,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: AppTheme.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Thin divider below tabs
            Container(
              height: 0.5,
              color: AppTheme.divider,
            ),

            // ─── SEARCH BAR: 🔍 Search & add | 25/250 | ⫦ filter ───
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search & add',
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.35),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                    Text(
                      '${_filteredStocks.length}/250',
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 22,
                      color: AppTheme.divider,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.tune_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 20,
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 2),

            // ─── STOCK LIST ───
            Expanded(
              child: _filteredStocks.isEmpty
                  ? Center(
                      child: Text(
                        'No stocks found',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _filteredStocks.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 0.5,
                        thickness: 0.5,
                        indent: 16,
                        endIndent: 16,
                        color: AppTheme.divider,
                      ),
                      itemBuilder: (context, index) {
                        final stock = _filteredStocks[index];
                        return StockTile(
                          stock: stock,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${stock.symbol} — ₹${stock.ltp}'),
                                duration: const Duration(seconds: 1),
                                backgroundColor: AppTheme.card,
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helper: build a single tab ───
  Widget _buildTab(String label, int index, bool hasLock) {
    final isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    color: isSelected ? AppTheme.blue : AppTheme.textSecondary,
                  ),
                ),
                if (hasLock) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 13,
                    color: isSelected ? AppTheme.blue : AppTheme.textSecondary,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 2.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
