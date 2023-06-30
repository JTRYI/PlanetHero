import 'package:flutter/material.dart';
import 'package:planethero_application/widgets/listview-bookmarks.dart';
import 'login_signup_screen.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class BookmarkScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/bookmarks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            'Bookmarks',
            style: TextStyle(
              fontFamily: 'Roboto Bold',
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
          child: Column(
            children: [
              Expanded(child: ListBookmarks()),
            ],
          ),
        ),
      ),
    );
  }
}
