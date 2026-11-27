// ─── Holdings (Portfolio → Holdings tab) ───
class Holding {
  final int qty;
  final String avg;
  final String symbol;
  final String invested;
  final double pnlPct; // +21.68
  final String pnlAbs; // "+605.15"
  final String ltp; // "79.00"
  final String ltpPct; // "(-3.21%)"
  const Holding({
    required this.qty,
    required this.avg,
    required this.symbol,
    required this.invested,
    required this.pnlPct,
    required this.pnlAbs,
    required this.ltp,
    required this.ltpPct,
  });
  bool get up => pnlPct >= 0;
}

const String holdingsInvested = '13,228.55';
const String holdingsCurrent = '15,463.77';
const String holdingsPnl = '+2,235.22';
const String holdingsPnlPct = '+16.90%';
const String holdingsDayPnl = '-269.55';
const String holdingsDayPct = '-1.71 %';

const List<Holding> holdings = [
  Holding(qty: 2, avg: '66.65', symbol: 'ALEMBICLTD', invested: '133.30', pnlPct: -3.60, pnlAbs: '-4.80', ltp: '64.25', ltpPct: '(-0.77%)'),
  Holding(qty: 43, avg: '64.92', symbol: 'BHEL', invested: '2,791.85', pnlPct: 21.68, pnlAbs: '+605.15', ltp: '79.00', ltpPct: '(-3.21%)'),
  Holding(qty: 16, avg: '98.17', symbol: 'GAIL', invested: '1,570.75', pnlPct: 8.94, pnlAbs: '+140.45', ltp: '106.95', ltpPct: '(-0.47%)'),
  Holding(qty: 11, avg: '6.98', symbol: 'IDEA', invested: '76.80', pnlPct: -2.17, pnlAbs: '-1.67', ltp: '6.83', ltpPct: '(-1.30%)'),
  Holding(qty: 11, avg: '80.24', symbol: 'IDFC', invested: '882.70', pnlPct: 12.19, pnlAbs: '+107.63', ltp: '90.03', ltpPct: '(-0.39%)'),
];

// ─── Positions (Portfolio → Positions tab) ───
enum ProdChip { nrml, holding, cnc }

class Position {
  final int qty;
  final String avg;
  final List<ProdChip> chips;
  final String symbol;
  final String exchange;
  final String pnl; // "-200.0000" / "+4.00"
  final String ltp;
  final bool up;
  const Position({
    required this.qty,
    required this.avg,
    required this.chips,
    required this.symbol,
    required this.exchange,
    required this.pnl,
    required this.ltp,
    required this.up,
  });
}

const String positionsTotalPnl = '-273.75';

const List<Position> positions = [
  Position(qty: -1, avg: '82.0375', chips: [ProdChip.nrml], symbol: 'USDINR23JUNFUT', exchange: 'CDS', pnl: '-200.0000', ltp: '0.00', up: false),
  Position(qty: 1, avg: '82.1625', chips: [ProdChip.nrml], symbol: 'USDINR23MAYFUT', exchange: 'CDS', pnl: '-42.5000', ltp: '0.00', up: false),
  Position(qty: 1, avg: '6,134.00', chips: [ProdChip.nrml], symbol: 'GOLDPETAL23MAYFUT', exchange: 'MCX', pnl: '+4.00', ltp: '0.00', up: true),
  Position(qty: -50, avg: '1.65', chips: [ProdChip.nrml], symbol: 'NIFTY2351118700CE', exchange: 'NFO', pnl: '-50.00', ltp: '0.00', up: false),
  Position(qty: 50, avg: '1.45', chips: [ProdChip.nrml], symbol: 'NIFTY2351118750CE', exchange: 'NFO', pnl: '-12.50', ltp: '0.00', up: false),
  Position(qty: 1, avg: '64.70', chips: [ProdChip.holding, ProdChip.cnc], symbol: 'IDFCFIRSTB', exchange: 'NSE', pnl: '-0.25', ltp: '64.45', up: false),
];
