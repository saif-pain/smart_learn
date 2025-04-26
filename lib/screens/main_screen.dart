import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/screens/home_screen.dart';
import 'package:smart_learn/screens/settings_page.dart';
import 'package:smart_learn/screens/account_settings_page.dart';
import 'package:smart_learn/screens/my_courses_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  DateTime? _lastBackPressTime;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyCoursesPage(),  // Changed from TopicsPage to MyCoursesPage
    const SettingsPage(),
    const AccountSettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (_selectedIndex != 0) {
          // If not on home tab, go to home tab
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        
        // On home tab, implement double back to exit
        final now = DateTime.now();
        if (_lastBackPressTime == null || 
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        
        // Exit app on second back press
        return true;
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor:
                  const Color.fromARGB(255, 78, 185, 201),
              unselectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 0
                      ? Icons.home
                      : Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 1
                      ? Icons.book
                      : Icons.book_outlined),
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 2
                      ? Icons.settings
                      : Icons.settings_outlined),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 3
                      ? Icons.person
                      : Icons.person_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
