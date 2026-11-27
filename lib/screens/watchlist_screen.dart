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

  // Watchlist tabs (scrollable row, JetKite style)
  final List<String> _tabs = const [
    'Nifty 50',
    'Bank Nifty',
    'My Stocks',
    'F&O',
    'Commodity',
  ];

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
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── SCROLLABLE TAB ROW (grey container, blue underline) ───
            Container(
              color: AppTheme.topSection,
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: _tabs.length,
                itemBuilder: (context, index) => _buildTab(_tabs[index], index),
              ),
            ),

            // ─── SEARCH BAND: white card floating over grey strip ───
            SizedBox(
              height: 92,
              child: Stack(
                children: [
                  // grey strip at top half (blends with tab row)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 46,
                      width: double.infinity,
                      color: AppTheme.topSection,
                    ),
                  ),
                  // floating white search card
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(4),
                        shadowColor: Colors.black.withOpacity(0.2),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.search,
                                color: AppTheme.searchHint,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                    });
                                  },
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: AppTheme.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search & add',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: AppTheme.searchHint,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              Text(
                                '${_filteredStocks.length}/50',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 22,
                                color: AppTheme.textSecondary.withOpacity(0.25),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.list,
                                  color: AppTheme.textSecondary,
                                  size: 24,
                                ),
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                                backgroundColor: AppTheme.textPrimary,
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

  // ─── Single scrollable tab with blue underline when selected ───
  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        color: AppTheme.topSection,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    label,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: isSelected ? AppTheme.blue : AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: isSelected ? AppTheme.blue : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
