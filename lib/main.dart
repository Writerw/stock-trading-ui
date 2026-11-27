import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/watchlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Trading App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const WatchlistScreen(),
    const Center(child: Text('Portfolio', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Orders', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Funds', style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFF2D77FF),
        unselectedItemColor: const Color(0xFF9E9E9E),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Funds',
          ),
        ],
      ),
    );
  }
}
