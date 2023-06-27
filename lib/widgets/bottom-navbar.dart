import 'package:flutter/material.dart';
import 'package:planethero_application/main.dart';
import 'package:planethero_application/screens/actions_screen.dart';
import 'package:planethero_application/screens/bookmarks_screen.dart';
import 'package:planethero_application/screens/leaderboard_screen.dart';
import 'package:planethero_application/screens/settings_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  // Variable that will be passed into the parameter of the Bottom Nav Bar
  final int initialIndex;

  // Constructor for Bottom Nav Bar
  const CustomBottomNavigationBar({required this.initialIndex});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _currentIndex;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to the respective screen based on the selected index
    switch (index) {
      case 0:
        Navigator.of(context)
            .pushNamed(MainScreen.routeName, arguments: _currentIndex);
        break;

      case 1:
        Navigator.of(context)
            .pushNamed(ActionScreen.routeName, arguments: _currentIndex);
        break;

      case 2:
        Navigator.of(context)
            .pushNamed(BookmarkScreen.routeName, arguments: _currentIndex);
        break;

      case 3:
        Navigator.of(context)
            .pushNamed(LeaderboardScreen.routeName, arguments: _currentIndex);
        break;

      case 4:
        Navigator.of(context)
            .pushNamed(SettingScreen.routeName, arguments: _currentIndex);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Makes all items in the bottom nav bar stay in the same position
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.greenAccent.shade400,
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
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
    );
  }
}
