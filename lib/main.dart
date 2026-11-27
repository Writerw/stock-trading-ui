import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme/app_theme.dart';
import 'screens/watchlist_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/portfolio_screen.dart';
import 'screens/ipo_screen.dart';
import 'screens/account_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // White status bar for light theme
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Stock Trading App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
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

  static const Color _inactiveColor = Color(0xFF424250); // exact grey from the Kite screenshot

  // Builds a nav item using the traced SVG icon: blue when selected, grey when not.
  BottomNavigationBarItem _navItem(String name, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          'assets/icons/$name.svg',
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(_inactiveColor, BlendMode.srcIn),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          'assets/icons/$name.svg',
          width: 28,
          height: 28,
          colorFilter: const ColorFilter.mode(AppTheme.blue, BlendMode.srcIn),
        ),
      ),
      label: label,
    );
  }

  final List<Widget> _screens = [
    const WatchlistScreen(),
    const OrdersScreen(),
    const PortfolioScreen(),
    const IpoScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: AppTheme.divider,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppTheme.blue,
          unselectedItemColor: _inactiveColor,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: [
            _navItem('watchlist', 'Watchlist'),
            _navItem('orders', 'Orders'),
            _navItem('portfolio', 'Portfolio'),
            _navItem('ipo', 'IPO & Bids'),
            _navItem('profile', 'DEMOUSER'),
          ],
        ),
      ),
    );
  }
}
