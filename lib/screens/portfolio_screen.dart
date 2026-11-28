import 'package:flutter/material.dart';
import '../theme/kite_text.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';
import '../widgets/kite_tabs.dart';

class PortfolioScreen extends StatefulWidget {
  final int initialTab;
  const PortfolioScreen({super.key, this.initialTab = 0});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late int _tab = widget.initialTab; // 0 = Holdings, 1 = Positions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.topSection,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const KiteAppBar(title: 'Portfolio'),
            KiteTabs(
              centered: true,
              tabPadding: 22,
              tabs: const [
                KiteTab('Holdings', badge: 17),
                KiteTab('Positions', badge: 8),
              ],
              selected: _tab,
              onSelect: (i) => setState(() => _tab = i),
            ),
            Expanded(child: _tab == 0 ? _holdings() : _positions()),
          ],
        ),
      ),
    );
  }

  Widget _panel({required Widget card, required Widget body}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7.92, 5.28, 7.92, 6.6),
          child: card,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(9.24)),
            ),
            clipBehavior: Clip.antiAlias,
            child: body,
          ),
        ),
      ],
    );
  }

  Widget _cardShell(Widget child) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(5.28),
      shadowColor: Colors.black.withOpacity(0.12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(5.28),
        ),
        padding: const EdgeInsets.fromLTRB(13.2, 11.88, 13.2, 11.88),
        child: child,
      ),
    );
  }

  TextStyle _label() =>
      inter(fontSize: 10.23, color: AppTheme.metaGrey);

  // ───────────────────────── HOLDINGS ─────────────────────────
  Widget _holdings() {
    return _panel(
      card: _cardShell(
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Invested', style: _label()),
                    const SizedBox(height: 3.96),
                    Text(holdingsInvested,
                        style: inter(
                            fontSize: 15.84, color: AppTheme.textPrimary)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Current', style: _label()),
                    const SizedBox(height: 3.96),
                    Text(holdingsCurrent,
                        style: inter(
                            fontSize: 15.84, color: AppTheme.textPrimary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.56),
            const Divider(height: 0.66, thickness: 0.4, color: AppTheme.divider),
            const SizedBox(height: 9.24),
            Row(
              children: [
                Text('P&L', style: _label()),
                const Spacer(),
                Text(holdingsPnl,
                    style: inter(
                        fontSize: 13.2, color: AppTheme.green)),
                const SizedBox(width: 7.92),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.6, vertical: 3.3),
                  decoration: BoxDecoration(
                      color: AppTheme.pillGreenBg,
                      borderRadius: BorderRadius.circular(3.96)),
                  child: Text(holdingsPnlPct,
                      style: inter(
                          fontSize: 9.24, color: AppTheme.green)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _holdingsToolbar(),
          const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: holdings.length,
              separatorBuilder: (_, __) => const Divider(
                  height: 0.33, thickness: 0.33, color: AppTheme.divider),
              itemBuilder: (context, i) => _holdingRow(holdings[i]),
            ),
          ),
          // pinned Day's P&L footer
          const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.56, 9.9, 10.56, 9.9),
            child: Row(
              children: [
                Text("Day's P&L",
                    style: inter(
                        fontSize: 10.56, color: AppTheme.textPrimary)),
                const Spacer(),
                Text(holdingsDayPnl,
                    style: inter(
                        fontSize: 10.56, color: AppTheme.red)),
                const SizedBox(width: 10.56),
                Text(holdingsDayPct,
                    style: inter(
                        fontSize: 10.56, color: AppTheme.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _holdingsToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 7.92, 10.56, 7.92),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 16.5),
          const SizedBox(width: 14.52),
          const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.tune, color: AppTheme.blue, size: 15.18)),
          const SizedBox(width: 11.88),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.92, vertical: 4.62),
            decoration: BoxDecoration(
                color: AppTheme.rowAltBg,
                borderRadius: BorderRadius.circular(3.96)),
            child: Row(
              children: [
                Text('Equity',
                    style: inter(
                        fontSize: 9.9, color: AppTheme.textPrimary)),
                const SizedBox(width: 1.98),
                const Icon(Icons.keyboard_arrow_down,
                    size: 13.2, color: AppTheme.textPrimary),
              ],
            ),
          ),
          const Spacer(),
          _toolAction(Icons.people_outline, 'Family'),
          const SizedBox(width: 11.88),
          _toolAction(Icons.donut_large, 'Analytics'),
        ],
      ),
    );
  }

  Widget _holdingRow(Holding h) {
    final c = h.up ? AppTheme.green : AppTheme.red;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 9.9, 10.56, 9.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _qtyAvg(h.qty, h.avg, colorQty: false)),
              Text('${h.pnlPct >= 0 ? '+' : ''}${h.pnlPct.toStringAsFixed(2)}%',
                  style: inter(fontSize: 9.57, color: c)),
            ],
          ),
          const SizedBox(height: 6.6),
          Row(
            children: [
              Expanded(
                child: Text(h.symbol,
                    style: inter(
                        fontSize: 10.89, color: AppTheme.textPrimary)),
              ),
              Text(h.pnlAbs,
                  style: inter(fontSize: 10.89, color: c)),
            ],
          ),
          const SizedBox(height: 5.94),
          Row(
            children: [
              Expanded(
                child: Text('Invested ${h.invested}',
                    style: inter(
                        fontSize: 8.58, color: AppTheme.metaGrey)),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'LTP ',
                    style: inter(
                        fontSize: 8.58, color: AppTheme.metaGrey)),
                TextSpan(
                    text: '${h.ltp} ',
                    style: inter(
                        fontSize: 8.58, color: AppTheme.textPrimary)),
                TextSpan(
                    text: h.ltpPct,
                    style: inter(
                        fontSize: 8.58, color: AppTheme.metaGrey)),
              ])),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────────────── POSITIONS ─────────────────────────
  Widget _positions() {
    return _panel(
      card: _cardShell(
        Column(
          children: [
            Text('Total P&L', style: _label()),
            const SizedBox(height: 5.28),
            Text(positionsTotalPnl,
                style: inter(fontSize: 17.16, color: AppTheme.red)),
          ],
        ),
      ),
      body: Column(
        children: [
          _positionsToolbar(),
          const Divider(height: 0.33, thickness: 0.33, color: AppTheme.divider),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: positions.length,
              separatorBuilder: (_, __) => const Divider(
                  height: 0.33, thickness: 0.33, color: AppTheme.divider),
              itemBuilder: (context, i) => _positionRow(positions[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionsToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 7.92, 10.56, 7.92),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 16.5),
          const SizedBox(width: 14.52),
          const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.tune, color: AppTheme.blue, size: 15.18)),
          const SizedBox(width: 13.2),
          _toolAction(Icons.segment, 'Group'),
          const Spacer(),
          _toolAction(Icons.candlestick_chart_outlined, 'Analyze'),
          const SizedBox(width: 11.88),
          _toolAction(Icons.donut_large, 'P&L'),
        ],
      ),
    );
  }

  Widget _positionRow(Position p) {
    final c = p.up ? AppTheme.green : AppTheme.red;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.56, 9.9, 10.56, 9.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _qtyAvg(p.qty, p.avg, colorQty: true)),
              Row(children: [for (final ch in p.chips) _prodChip(ch)]),
            ],
          ),
          const SizedBox(height: 7.26),
          Row(
            children: [
              Expanded(
                child: Text(p.symbol,
                    style: inter(
                        fontSize: 10.89, color: AppTheme.textPrimary)),
              ),
              Text(p.pnl,
                  style: inter(fontSize: 10.89, color: c)),
            ],
          ),
          const SizedBox(height: 5.94),
          Row(
            children: [
              Expanded(
                child: Text(p.exchange,
                    style: inter(
                        fontSize: 8.58, color: AppTheme.metaGrey)),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'LTP ',
                    style: inter(
                        fontSize: 8.58, color: AppTheme.metaGrey)),
                TextSpan(
                    text: p.ltp,
                    style: inter(
                        fontSize: 8.58, color: AppTheme.textPrimary)),
              ])),
            ],
          ),
        ],
      ),
    );
  }

  // shared bits
  Widget _qtyAvg(int qty, String avg, {required bool colorQty}) {
    final qtyColor = !colorQty
        ? AppTheme.textPrimary
        : (qty < 0 ? AppTheme.red : AppTheme.blue);
    return Row(
      children: [
        Text('Qty. ', style: inter(fontSize: 9.57, color: AppTheme.metaGrey)),
        Text('$qty', style: inter(fontSize: 9.57, color: qtyColor)),
        const SizedBox(width: 5.28),
        if (!colorQty) ...[
          Text('• ', style: inter(fontSize: 9.57, color: AppTheme.metaGrey)),
        ],
        Text('Avg. ', style: inter(fontSize: 9.57, color: AppTheme.metaGrey)),
        Text(avg, style: inter(fontSize: 9.57, color: AppTheme.textPrimary)),
      ],
    );
  }

  Widget _prodChip(ProdChip ch) {
    late Color bg, fg;
    late String text;
    switch (ch) {
      case ProdChip.nrml:
        bg = AppTheme.chipPurpleBg;
        fg = AppTheme.chipPurpleText;
        text = 'NRML';
        break;
      case ProdChip.holding:
        bg = AppTheme.chipBlueBg;
        fg = AppTheme.blue;
        text = 'HOLDING';
        break;
      case ProdChip.cnc:
        bg = AppTheme.chipGreyBg;
        fg = AppTheme.textPrimary;
        text = 'CNC';
        break;
    }
    return Container(
      margin: const EdgeInsets.only(left: 5.28),
      padding: const EdgeInsets.symmetric(horizontal: 6.6, vertical: 3.96),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(1.98)),
      child: Text(text,
          style: inter(
              fontSize: 8.25, fontWeight: FontWeight.w500, color: fg)),
    );
  }

  Widget _toolAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 13.86, color: AppTheme.blue),
        const SizedBox(width: 3.96),
        Text(label,
            style: inter(
                fontSize: 10.23, fontWeight: FontWeight.w500, color: AppTheme.blue)),
      ],
    );
  }
}
