import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/kite_app_bar.dart';
import '../widgets/kite_tabs.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _tab = 0; // 0 = Holdings, 1 = Positions

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
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: card,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
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
      borderRadius: BorderRadius.circular(8),
      shadowColor: Colors.black.withOpacity(0.12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        child: child,
      ),
    );
  }

  TextStyle _label() =>
      GoogleFonts.inter(fontSize: 15.5, color: AppTheme.metaGrey);

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
                    const SizedBox(height: 6),
                    Text(holdingsInvested,
                        style: GoogleFonts.inter(
                            fontSize: 24, color: AppTheme.textPrimary)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Current', style: _label()),
                    const SizedBox(height: 6),
                    Text(holdingsCurrent,
                        style: GoogleFonts.inter(
                            fontSize: 24, color: AppTheme.textPrimary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 0.6, color: AppTheme.divider),
            const SizedBox(height: 14),
            Row(
              children: [
                Text('P&L', style: _label()),
                const Spacer(),
                Text(holdingsPnl,
                    style: GoogleFonts.inter(
                        fontSize: 20, color: AppTheme.green)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppTheme.pillGreenBg,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(holdingsPnlPct,
                      style: GoogleFonts.inter(
                          fontSize: 14, color: AppTheme.green)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _holdingsToolbar(),
          const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: holdings.length,
              separatorBuilder: (_, __) => const Divider(
                  height: 0.5, thickness: 0.5, color: AppTheme.divider),
              itemBuilder: (context, i) => _holdingRow(holdings[i]),
            ),
          ),
          // pinned Day's P&L footer
          const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
            child: Row(
              children: [
                Text("Day's P&L",
                    style: GoogleFonts.inter(
                        fontSize: 16, color: AppTheme.textPrimary)),
                const Spacer(),
                Text(holdingsDayPnl,
                    style: GoogleFonts.inter(
                        fontSize: 16, color: AppTheme.red)),
                const SizedBox(width: 16),
                Text(holdingsDayPct,
                    style: GoogleFonts.inter(
                        fontSize: 16, color: AppTheme.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _holdingsToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 25),
          const SizedBox(width: 22),
          const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.tune, color: AppTheme.blue, size: 23)),
          const SizedBox(width: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                color: AppTheme.rowAltBg,
                borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: [
                Text('Equity',
                    style: GoogleFonts.inter(
                        fontSize: 15, color: AppTheme.textPrimary)),
                const SizedBox(width: 3),
                const Icon(Icons.keyboard_arrow_down,
                    size: 20, color: AppTheme.textPrimary),
              ],
            ),
          ),
          const Spacer(),
          _toolAction(Icons.people_outline, 'Family'),
          const SizedBox(width: 18),
          _toolAction(Icons.donut_large, 'Analytics'),
        ],
      ),
    );
  }

  Widget _holdingRow(Holding h) {
    final c = h.up ? AppTheme.green : AppTheme.red;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _qtyAvg(h.qty, h.avg, colorQty: false)),
              Text('${h.pnlPct >= 0 ? '+' : ''}${h.pnlPct.toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(fontSize: 14.5, color: c)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(h.symbol,
                    style: GoogleFonts.inter(
                        fontSize: 16.5, color: AppTheme.textPrimary)),
              ),
              Text(h.pnlAbs,
                  style: GoogleFonts.inter(fontSize: 16.5, color: c)),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: Text('Invested ${h.invested}',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.metaGrey)),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'LTP ',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.metaGrey)),
                TextSpan(
                    text: '${h.ltp} ',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.textPrimary)),
                TextSpan(
                    text: h.ltpPct,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.metaGrey)),
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
            const SizedBox(height: 8),
            Text(positionsTotalPnl,
                style: GoogleFonts.inter(fontSize: 26, color: AppTheme.red)),
          ],
        ),
      ),
      body: Column(
        children: [
          _positionsToolbar(),
          const Divider(height: 0.5, thickness: 0.5, color: AppTheme.divider),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: positions.length,
              separatorBuilder: (_, __) => const Divider(
                  height: 0.5, thickness: 0.5, color: AppTheme.divider),
              itemBuilder: (context, i) => _positionRow(positions[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionsToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppTheme.blue, size: 25),
          const SizedBox(width: 22),
          const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.tune, color: AppTheme.blue, size: 23)),
          const SizedBox(width: 20),
          _toolAction(Icons.segment, 'Group'),
          const Spacer(),
          _toolAction(Icons.candlestick_chart_outlined, 'Analyze'),
          const SizedBox(width: 18),
          _toolAction(Icons.donut_large, 'P&L'),
        ],
      ),
    );
  }

  Widget _positionRow(Position p) {
    final c = p.up ? AppTheme.green : AppTheme.red;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _qtyAvg(p.qty, p.avg, colorQty: true)),
              Row(children: [for (final ch in p.chips) _prodChip(ch)]),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Expanded(
                child: Text(p.symbol,
                    style: GoogleFonts.inter(
                        fontSize: 16.5, color: AppTheme.textPrimary)),
              ),
              Text(p.pnl,
                  style: GoogleFonts.inter(fontSize: 16.5, color: c)),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: Text(p.exchange,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.metaGrey)),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'LTP ',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.metaGrey)),
                TextSpan(
                    text: p.ltp,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.textPrimary)),
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
        Text('Qty. ', style: GoogleFonts.inter(fontSize: 14.5, color: AppTheme.metaGrey)),
        Text('$qty', style: GoogleFonts.inter(fontSize: 14.5, color: qtyColor)),
        const SizedBox(width: 8),
        if (!colorQty) ...[
          Text('• ', style: GoogleFonts.inter(fontSize: 14.5, color: AppTheme.metaGrey)),
        ],
        Text('Avg. ', style: GoogleFonts.inter(fontSize: 14.5, color: AppTheme.metaGrey)),
        Text(avg, style: GoogleFonts.inter(fontSize: 14.5, color: AppTheme.textPrimary)),
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
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(3)),
      child: Text(text,
          style: GoogleFonts.inter(
              fontSize: 12.5, fontWeight: FontWeight.w500, color: fg)),
    );
  }

  Widget _toolAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 21, color: AppTheme.blue),
        const SizedBox(width: 6),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 15.5, fontWeight: FontWeight.w500, color: AppTheme.blue)),
      ],
    );
  }
}
