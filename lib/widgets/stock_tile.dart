import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const StockTile({
    super.key,
    required this.stock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = stock.isPositive ? AppTheme.green : AppTheme.red;
    final changePrefix = stock.isPositive ? '+' : '';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'NSE',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.ltp.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  '$changePrefix${stock.change.toStringAsFixed(2)}%',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: changeColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
