import 'package:flutter/material.dart';

class OrderItem {
  final bool isBuy;
  final String qty; // "0/1"
  final String time; // "13:39:12"
  final String status; // "OPEN"
  final String symbol;
  final String price; // "0.00 / 48.50 trg."
  final String tags; // "NSE   CO   SL-M"
  final String ltp; // "49.30"
  final IconData? noteIcon;
  final String? noteText;

  const OrderItem({
    required this.isBuy,
    required this.qty,
    required this.time,
    required this.status,
    required this.symbol,
    required this.price,
    required this.tags,
    required this.ltp,
    this.noteIcon,
    this.noteText,
  });
}

// Exact rows from the Kite "Orders → Open" screenshot
const List<OrderItem> openOrders = [
  OrderItem(
    isBuy: false, qty: '0/1', time: '13:39:12', status: 'OPEN',
    symbol: 'PNB', price: '0.00 / 48.50 trg.',
    tags: 'NSE   CO   SL-M', ltp: '49.30',
  ),
  OrderItem(
    isBuy: true, qty: '0/1', time: '13:39:12', status: 'OPEN',
    symbol: 'INFY', price: '49.50 / 48.50 trg.',
    tags: 'NSE   CO   LIMIT', ltp: '1,246.90',
  ),
  OrderItem(
    isBuy: true, qty: '0/3', time: '13:35:15', status: 'OPEN',
    symbol: 'USDINR23MAYFUT', price: '81.0000',
    tags: 'CDS   NRML   LIMIT', ltp: '0.00',
    noteIcon: Icons.call_split, noteText: '1/2',
  ),
  OrderItem(
    isBuy: true, qty: '0/1', time: '13:34:15', status: 'OPEN',
    symbol: 'USDINR23MAYFUT', price: '81.0000',
    tags: 'CDS   MIS   LIMIT', ltp: '0.00',
    noteIcon: Icons.hourglass_empty,
  ),
  OrderItem(
    isBuy: true, qty: '0/1', time: '13:32:12', status: 'OPEN',
    symbol: 'SBIN', price: '585.00 / 585.00 trg.',
    tags: 'BSE   MIS   SL', ltp: '586.50',
  ),
  OrderItem(
    isBuy: true, qty: '0/1', time: '13:29:52', status: 'OPEN',
    symbol: 'VEDL', price: '0.00 / 290.00 trg.',
    tags: 'NSE   CNC   SL-M', ltp: '279.45',
  ),
];
