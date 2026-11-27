import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/orders_data.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';
import '../widgets/kite_tabs.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.topSection,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const KiteAppBar(title: 'Orders'),
            KiteTabs(
              tabs: const [
                KiteTab('Open', badge: 6),
                KiteTab('Executed', badge: 5),
                KiteTab('GTT'),
                KiteTab('Baskets'),
                KiteTab('SIP'),
              ],
              selected: _tab,
              onSelect: (i) => setState(() => _tab = i),
            ),
            // white panel with rounded top corners
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _toolbar(),
                    const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: openOrders.length,
                        separatorBuilder: (_, __) => const Divider(
                            height: 0.5, thickness: 0.5, color: AppTheme.divider),
                        itemBuilder: (context, i) => _orderRow(openOrders[i]),
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
      padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 25),
          const SizedBox(width: 24),
          const RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.tune, color: AppTheme.blue, size: 23),
          ),
          const Spacer(),
          const Icon(Icons.radio_button_checked, color: AppTheme.blue, size: 21),
          const SizedBox(width: 9),
          Text(
            'Tradebook',
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(3)),
      child: Text(
        text,
        style: GoogleFonts.inter(
            fontSize: 12.5, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }

  Widget _orderRow(OrderItem o) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // line 1: BUY/SELL chip, qty, time, status
          Row(
            children: [
              _chip(
                o.isBuy ? 'BUY' : 'SELL',
                o.isBuy ? AppTheme.chipBlueBg : AppTheme.chipRedBg,
                o.isBuy ? AppTheme.blue : AppTheme.red,
              ),
              const SizedBox(width: 11),
              Text(o.qty,
                  style: GoogleFonts.inter(
                      fontSize: 14.5, color: AppTheme.textPrimary)),
              const Spacer(),
              const Icon(Icons.access_time, size: 15, color: AppTheme.metaGrey),
              const SizedBox(width: 4),
              Text(o.time,
                  style: GoogleFonts.inter(
                      fontSize: 13.5, color: AppTheme.metaGrey)),
              const SizedBox(width: 11),
              _chip(o.status, AppTheme.chipGreyBg, AppTheme.textPrimary),
            ],
          ),
          const SizedBox(height: 12),
          // line 2: symbol + price
          Row(
            children: [
              Expanded(
                child: Text(o.symbol,
                    style: GoogleFonts.inter(
                        fontSize: 16.5, color: AppTheme.textPrimary)),
              ),
              Text(o.price,
                  style: GoogleFonts.inter(
                      fontSize: 16.5, color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 9),
          // line 3: tags + LTP
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(o.tags,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 13, color: AppTheme.metaGrey)),
                    ),
                    if (o.noteIcon != null) ...[
                      const SizedBox(width: 9),
                      Icon(o.noteIcon, size: 14, color: AppTheme.metaGrey),
                    ],
                    if (o.noteText != null) ...[
                      const SizedBox(width: 3),
                      Text(o.noteText!,
                          style: GoogleFonts.inter(
                              fontSize: 13, color: AppTheme.metaGrey)),
                    ],
                  ],
                ),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: 'LTP ',
                      style: GoogleFonts.inter(
                          fontSize: 13, color: AppTheme.metaGrey)),
                  TextSpan(
                      text: o.ltp,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: AppTheme.textPrimary)),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
