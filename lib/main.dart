import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          unselectedItemColor: const Color(0xFF7B7B7B),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: const [
            // Watchlist — bookmark/flag icon (Kite uses a bookmark ribbon)
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.bookmark_outline, size: 26),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.bookmark, size: 26),
              ),
              label: 'Watchlist',
            ),
            // Orders — book/notebook icon
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.menu_book_outlined, size: 26),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.menu_book, size: 26),
              ),
              label: 'Orders',
            ),
            // Portfolio — briefcase/suitcase icon
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.work_outline, size: 26),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.work, size: 26),
              ),
              label: 'Portfolio',
            ),
            // IPO & Bids — gavel/auction icon
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.gavel_outlined, size: 26),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.gavel, size: 26),
              ),
              label: 'IPO & Bids',
            ),
            // DEMOUSER — person icon
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.person_outline, size: 26),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(Icons.person, size: 26),
              ),
              label: 'DEMOUSER',
            ),
          ],
        ),
      ),
    );
  }
}
