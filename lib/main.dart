import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme/app_theme.dart';
import 'screens/watchlist_screen.dart';

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

  static const Color _inactiveColor = AppTheme.textSecondary; // #44474F (JetKite onSurfaceVariant)

  // Builds a nav item using custom SVG icons (outline when inactive, filled when selected)
  BottomNavigationBarItem _navItem(String name, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          'assets/icons/${name}_outline.svg',
          width: 25,
          height: 25,
          colorFilter: const ColorFilter.mode(_inactiveColor, BlendMode.srcIn),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          'assets/icons/${name}_filled.svg',
          width: 25,
          height: 25,
          colorFilter: const ColorFilter.mode(AppTheme.blue, BlendMode.srcIn),
        ),
      ),
      label: label,
    );
  }

  final List<Widget> _screens = [
    const WatchlistScreen(),
    Center(child: Text('Orders', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18))),
    Center(child: Text('Portfolio', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18))),
    Center(child: Text('IPO & Bids', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18))),
    Center(child: Text('Profile', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18))),
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
          unselectedItemColor: AppTheme.textSecondary,
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
