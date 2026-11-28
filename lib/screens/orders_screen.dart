import 'package:flutter/material.dart';
import '../theme/kite_text.dart';
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(9.24)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _toolbar(),
                    const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: openOrders.length,
                        separatorBuilder: (_, __) => const Divider(
                            height: 0.33, thickness: 0.33, color: AppTheme.divider),
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
      padding: const EdgeInsets.fromLTRB(10.56, 8.58, 10.56, 8.58),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 16.5),
          const SizedBox(width: 15.84),
          const RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.tune, color: AppTheme.blue, size: 15.18),
          ),
          const Spacer(),
          const Icon(Icons.radio_button_checked, color: AppTheme.blue, size: 13.86),
          const SizedBox(width: 5.94),
          Text(
            'Tradebook',
            style: inter(
                fontSize: 10.56, fontWeight: FontWeight.w500, color: AppTheme.blue),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.6, vertical: 3.3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(1.98)),
      child: Text(
        text,
        style: inter(
            fontSize: 8.25, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }

  Widget _orderRow(OrderItem o) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 9.9, 10.56, 9.9),
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
              const SizedBox(width: 7.26),
              Text(o.qty,
                  style: inter(
                      fontSize: 9.57, color: AppTheme.textPrimary)),
              const Spacer(),
              const Icon(Icons.access_time, size: 9.9, color: AppTheme.metaGrey),
              const SizedBox(width: 2.64),
              Text(o.time,
                  style: inter(
                      fontSize: 8.91, color: AppTheme.metaGrey)),
              const SizedBox(width: 7.26),
              _chip(o.status, AppTheme.chipGreyBg, AppTheme.textPrimary),
            ],
          ),
          const SizedBox(height: 7.92),
          // line 2: symbol + price
          Row(
            children: [
              Expanded(
                child: Text(o.symbol,
                    style: inter(
                        fontSize: 10.89, color: AppTheme.textPrimary)),
              ),
              Text(o.price,
                  style: inter(
                      fontSize: 10.89, color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 5.94),
          // line 3: tags + LTP
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(o.tags,
                          overflow: TextOverflow.ellipsis,
                          style: inter(
                              fontSize: 8.58, color: AppTheme.metaGrey)),
                    ),
                    if (o.noteIcon != null) ...[
                      const SizedBox(width: 5.94),
                      Icon(o.noteIcon, size: 9.24, color: AppTheme.metaGrey),
                    ],
                    if (o.noteText != null) ...[
                      const SizedBox(width: 1.98),
                      Text(o.noteText!,
                          style: inter(
                              fontSize: 8.58, color: AppTheme.metaGrey)),
                    ],
                  ],
                ),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: 'LTP ',
                      style: inter(
                          fontSize: 8.58, color: AppTheme.metaGrey)),
                  TextSpan(
                      text: o.ltp,
                      style: inter(
                          fontSize: 8.58, color: AppTheme.textPrimary)),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
