import 'package:flutter/material.dart';
import 'package:planethero_application/widgets/bottom-navbar.dart';

class BookmarkScreen extends StatelessWidget {

  //declare route name
  static String routeName = '/bookmarks';

  @override
  Widget build(BuildContext context) {
    final int initialIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(initialIndex: initialIndex),
    );
  }
}
