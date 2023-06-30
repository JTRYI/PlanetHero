import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:planethero_application/screens/actions_screen.dart';
import 'package:planethero_application/screens/bookmarks_screen.dart';
import 'package:planethero_application/screens/leaderboard_screen.dart';
import 'package:planethero_application/screens/settings_screen.dart';

import '../main.dart';

class ParentScreen extends StatefulWidget {
  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0; // Index of the currently selected tab
  var reverse = false; // Flag to determine if the transition should be reversed
  // List of screens to be displayed based on the selected tab
  var screens = [
    MainScreen(),
    ActionScreen(),
    BookmarkScreen(),
    LeaderboardScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 750),
        reverse: reverse,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          // Transition animation using SharedAxisTransition
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: screens[
            _currentIndex], // Display the screen based on the selected tab
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.greenAccent.shade400,
        onTap: _onItemTapped,
        currentIndex: _currentIndex, // Index of the currently selected tab
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(fontSize: 12), // Font size for selected labels
        unselectedLabelStyle:
            TextStyle(fontSize: 12), // Font size for unselected labels
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Method to handle tab selection
  void _onItemTapped(int value) {
    setState(() {
      reverse = value <
          _currentIndex; // Set the reverse flag based on the tab selection
      _currentIndex = value; // Update the selected tab index
    });
  }
}
