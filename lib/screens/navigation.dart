import 'package:flutter/material.dart';
import '../widgets/curved_navbar.dart';
import 'home_screen.dart';
import 'itinerary_screen.dart';
import 'packages_screen.dart';
import 'about_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final _pages = const [
    HomeScreen(),
    ItineraryScreen(),
    PackagesScreen(),
    AboutScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: CurvedNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
