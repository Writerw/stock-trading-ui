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
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search stocks e.g. RELIANCE',
                hintStyle: Theme.of(context).textTheme.bodySmall,
                prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary, size: 20),
                filled: true,
                fillColor: AppTheme.card,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredStocks.length} stocks',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'NSE',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
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
    );
  }
}
