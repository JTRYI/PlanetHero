import 'package:flutter/material.dart';
import '../widgets/listview-leaderboard.dart';
import 'login_signup_screen.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class LeaderboardScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 15), //give 15px of spacing from top of container for column
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.greenAccent.shade700,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Leaderboard',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.greenAccent.shade700,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ), //give spacing between leaderboard title and next container
              Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.greenAccent.shade700.withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Ranking',
                      style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right:
                              120), //Move 'User' text 150px from 'Point' Text
                      child: Text(
                        'User',
                        style:
                            TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                      ),
                    ),
                    Text(
                      'Points',
                      style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ), //leave 20px of space between row and list view leaderboard
              Expanded(child: ListLeaderboard()),
            ],
          ),
        ),
      ),
    );
  }
}
