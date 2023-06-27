import 'package:flutter/material.dart';
import 'package:planethero_application/providers/all_users.dart';

import 'package:provider/provider.dart';

class UserStats extends StatefulWidget {
  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  @override
  Widget build(BuildContext context) {
    //declare the provider
    AllUsers usersList = Provider.of<AllUsers>(context);

    //Get logged-in user ranking
    int loggedInUserRanking = usersList.getLoggedInUserRanking();
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 225,
      decoration: BoxDecoration(
        color: Colors.white, //Background colour of container
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3), //Shadow color with opacity
              blurRadius: 15, //Amount of blur for the shadow
              spreadRadius: 5) //Spread of the shadow
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // rows will be spaced evenly in the container
        children: [
          Row(
            children: [
              SizedBox(
                  width: 20), //space at the left of the container and image
              Image.asset('images/Actions.png'),
              Padding(
                padding: EdgeInsets.only(
                    left: 15), //15px of space between text and image
                child: Text(
                  'Actions Completed',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(
                  width:
                      125), //125px of space between the previous text and next text
              Text(
                '${usersList.loggedInUser?.actionsCompleted}',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Image.asset('images/Hero.png'),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Hero Points',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 175,
              ),
              Text(
                "${usersList.loggedInUser?.heroPoints}",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset('images/leaderboard.png'),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Ranking',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 15, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 200,
              ),
              Text(
                loggedInUserRanking.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
