class Stock {
  final String symbol;
  final String exchange; // e.g. "INDICES", "NSE"
  final double ltp;
  final double changeAbs; // absolute change, e.g. -104.75
  final double changePct; // percent change, e.g. -0.57

  const Stock({
    required this.symbol,
    required this.exchange,
    required this.ltp,
    required this.changeAbs,
    required this.changePct,
  });

  bool get isPositive => changeAbs >= 0;

  // 18181.75 -> "18,181.75" (thousands grouped, 2 decimals)
  String get ltpDisplay => _grouped(ltp);

  // "-104.75 (-0.57%)" / "+41.35 (+0.42%)"
  String get changeDisplay {
    final sign = isPositive ? '+' : '-';
    final abs = changeAbs.abs().toStringAsFixed(2);
    final pct = changePct.abs().toStringAsFixed(2);
    return '$sign$abs ($sign$pct%)';
  }

  static String _grouped(double v) {
    final parts = v.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final buf = StringBuffer();
    final n = intPart.length;
    for (int i = 0; i < n; i++) {
      buf.write(intPart[i]);
      final remaining = n - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buf.write(',');
    }
    return '${buf.toString()}.${parts[1]}';
  }
}

// Exact index rows from the Kite watchlist screenshot
final List<Stock> dummyStocks = [
  const Stock(symbol: 'NIFTY 50', exchange: 'INDICES', ltp: 18181.75, changeAbs: -104.75, changePct: -0.57),
  const Stock(symbol: 'NIFTY NEXT 50', exchange: 'INDICES', ltp: 40821.40, changeAbs: -230.65, changePct: -0.56),
  const Stock(symbol: 'NIFTY 100', exchange: 'INDICES', ltp: 18056.70, changeAbs: -105.55, changePct: -0.58),
  const Stock(symbol: 'NIFTY 200', exchange: 'INDICES', ltp: 9511.70, changeAbs: -49.25, changePct: -0.51),
  const Stock(symbol: 'NIFTY MIDCAP 150', exchange: 'INDICES', ltp: 12284.35, changeAbs: -8.70, changePct: -0.07),
  const Stock(symbol: 'NIFTY SMLCAP 250', exchange: 'INDICES', ltp: 9718.30, changeAbs: 41.35, changePct: 0.42),
  const Stock(symbol: 'NIFTY BANK', exchange: 'INDICES', ltp: 43698.70, changeAbs: -205.00, changePct: -0.46),
  const Stock(symbol: 'NIFTY IT', exchange: 'INDICES', ltp: 27942.95, changeAbs: -273.05, changePct: -0.96),
  const Stock(symbol: 'NIFTY AUTO', exchange: 'INDICES', ltp: 13889.90, changeAbs: 12.20, changePct: 0.08),
  const Stock(symbol: 'NIFTY PHARMA', exchange: 'INDICES', ltp: 12398.55, changeAbs: -55.95, changePct: -0.44),
  const Stock(symbol: 'NIFTY FMCG', exchange: 'INDICES', ltp: 45012.25, changeAbs: 88.40, changePct: 0.20),
  const Stock(symbol: 'NIFTY METAL', exchange: 'INDICES', ltp: 6421.15, changeAbs: -31.80, changePct: -0.49),
];
