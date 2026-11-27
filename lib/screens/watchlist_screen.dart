import 'package:flutter/material.dart';
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

  final List<String> _watchlistTabs = [
    'Nifty 50',
    'My Stocks',
    'Indices',
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Watchlist',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.textSecondary,
                    size: 28,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Watchlist tabs row
            SizedBox(
              height: 36,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 16),
                      itemCount: _watchlistTabs.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedTab == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTab = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _watchlistTabs[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? AppTheme.blue
                                        : AppTheme.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 2,
                                  width: _watchlistTabs[index].length * 7.5,
                                  color: isSelected
                                      ? AppTheme.blue
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Add watchlist button
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 8),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.card,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.blue,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Search bar with count and filter
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.search, color: AppTheme.textSecondary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search & add',
                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    Text(
                      '${_filteredStocks.length}/250',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 20,
                      color: AppTheme.divider,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.tune, color: AppTheme.textSecondary, size: 18),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),

            // Stock list
            Expanded(
              child: _filteredStocks.isEmpty
                  ? Center(
                      child: Text(
                        'No stocks found',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredStocks.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
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
}
