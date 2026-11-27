class IpoItem {
  final String company; // "Nexus Select Trust"
  final String symbol; // "NXST"
  final bool sme;
  final bool openForApply; // true -> Apply button, false -> CLOSED chip
  final String priceBand; // "₹95 - ₹100"
  final String dates; // "9th - 11th May"

  const IpoItem({
    required this.company,
    required this.symbol,
    required this.sme,
    required this.openForApply,
    required this.priceBand,
    required this.dates,
  });
}

// Exact rows from the Kite "IPO & Bids → Ongoing" screenshot
const List<IpoItem> ongoingIpos = [
  IpoItem(
    company: 'Nexus Select Trust', symbol: 'NXST', sme: false,
    openForApply: true, priceBand: '₹95 - ₹100', dates: '9th - 11th May',
  ),
  IpoItem(
    company: 'Innokaiz India Limited', symbol: 'INNOKAIZ', sme: true,
    openForApply: false, priceBand: '₹76 - ₹78', dates: '28th Apr - 3rd May',
  ),
  IpoItem(
    company: 'De Neers Tools Limited', symbol: 'DENEERS', sme: true,
    openForApply: false, priceBand: '₹95 - ₹101', dates: '28th Apr - 3rd May',
  ),
  IpoItem(
    company: 'Mankind Pharma Limited', symbol: 'MANKIND', sme: false,
    openForApply: false, priceBand: '₹1026 - ₹1080', dates: '25th - 27th Apr',
  ),
  IpoItem(
    company: 'Retina Paints Limited', symbol: 'RETINA', sme: true,
    openForApply: false, priceBand: '₹30', dates: '19th - 24th Apr',
  ),
];
