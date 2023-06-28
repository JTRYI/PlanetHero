import 'package:flutter/material.dart';
import 'package:planethero_application/widgets/search-bar.dart';

import '../widgets/bottom-navbar.dart';

class ActionScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/actions';

  @override
  Widget build(BuildContext context) {
    final int initialIndex =
        ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        initialIndex: initialIndex,
      ),
      body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15), //15px of space from top of screen
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //crossaxisalignment.start allows whatever items in
                //the column to start from the starting point of the search bar
                children: [
                  SearchBar(), //Search Bar Widget
                  SizedBox(
                    height: 20, //Space between search bar and "Actions" Title
                  ),
                  Text(
                    'Actions',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
                  ),
                  SizedBox(
                    height: 5, //Space between "Actions" Title and subtext
                  ),
                  Text(
                    'Steps you can take to build a Sustainable Future!',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                  )
                ]),
          )),
    );
  }
}
