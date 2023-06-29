import 'package:flutter/material.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/widgets/search-bar.dart';
import '../widgets/listview-actions.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class ActionScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/actions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 35, right: 35, bottom: 30),
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
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: ListActions())
            ]),
      ),
    );
  }
}
