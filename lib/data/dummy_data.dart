class Stock {
  final String symbol;
  final String name;
  final double ltp;
  final double open;
  final double high;
  final double low;
  final double change;

  const Stock({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.open,
    required this.high,
    required this.low,
    required this.change,
  });

  bool get isPositive => change >= 0;
}

final List<Stock> dummyStocks = [
  const Stock(symbol: 'RELIANCE', name: 'Reliance Industries', ltp: 2388.40, open: 2379.00, high: 2400.15, low: 2365.40, change: 0.72),
  const Stock(symbol: 'TCS', name: 'Tata Consultancy Svcs', ltp: 3415.20, open: 3409.70, high: 3424.80, low: 3391.85, change: -0.15),
  const Stock(symbol: 'INFY', name: 'Infosys Ltd', ltp: 1482.55, open: 1477.35, high: 1490.00, low: 1475.20, change: 0.39),
  const Stock(symbol: 'HDFCBANK', name: 'HDFC Bank Ltd', ltp: 1611.90, open: 1605.25, high: 1618.40, low: 1600.10, change: 0.54),
  const Stock(symbol: 'ICICIBANK', name: 'ICICI Bank Ltd', ltp: 891.45, open: 888.50, high: 894.90, low: 883.15, change: 0.88),
  const Stock(symbol: 'SBIN', name: 'State Bank of India', ltp: 595.75, open: 591.80, high: 598.60, low: 590.25, change: 1.09),
  const Stock(symbol: 'TATAMOTORS', name: 'Tata Motors Ltd', ltp: 473.60, open: 469.90, high: 475.80, low: 467.35, change: 1.46),
  const Stock(symbol: 'ITC', name: 'ITC Ltd', ltp: 357.85, open: 354.60, high: 359.10, low: 353.80, change: 0.68),
  const Stock(symbol: 'LT', name: 'Larsen & Toubro', ltp: 2185.15, open: 2179.25, high: 2198.60, low: 2163.90, change: 0.43),
  const Stock(symbol: 'WIPRO', name: 'Wipro Ltd', ltp: 395.95, open: 398.50, high: 399.70, low: 394.25, change: -1.12),
  const Stock(symbol: 'BHARTIARTL', name: 'Bharti Airtel Ltd', ltp: 775.20, open: 771.15, high: 777.90, low: 768.40, change: 0.34),
  const Stock(symbol: 'AXISBANK', name: 'Axis Bank Ltd', ltp: 920.65, open: 914.30, high: 923.75, low: 911.80, change: 1.06),
];
