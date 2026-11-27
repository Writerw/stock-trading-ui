import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const StockTile({super.key, required this.stock, this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceColor = stock.isPositive ? AppTheme.green : AppTheme.red;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: symbol + exchange
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    stock.exchange,
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      color: AppTheme.indicesGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Right: colored LTP + neutral-dark change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.ltpDisplay,
                  style: GoogleFonts.inter(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w400,
                    color: priceColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  stock.changeDisplay,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textPrimary,
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
