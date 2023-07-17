import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/all_users.dart';

class ListLeaderboard extends StatefulWidget {
  @override
  State<ListLeaderboard> createState() => _ListLeaderboardState();
}

class _ListLeaderboardState extends State<ListLeaderboard> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    // Access the provider and call fetchTopUsers in initState
    Provider.of<AllUsers>(context, listen: false).fetchTopUsers().then((_) {
      setState(() {
        _isLoading = false; // Set loading state to false after data is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //declare user provider
    AllUsers allUsers = Provider.of<AllUsers>(context);

    List<UserObject> topUsers =
        allUsers.users; // Access the top users from the provider

    int itemCount = topUsers.length;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            itemBuilder: (ctx, i) {
              //create the current user variable
              UserObject currentUser = topUsers[i];
              //create variable called ranking, +1 since index starts from 0
              int ranking = i + 1;
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ranking == 1
                      ? Colors.yellow
                          .shade700 //if ranking is 1, return gold colour container
                      : ranking == 2
                          ? Colors.blueGrey
                              .shade200 //elif ranking is 2, return silver colour container
                          : ranking == 3
                              ? Colors.brown
                                  .shade400 //elif ranking is 3, return bronze colour container
                              : Colors.greenAccent.shade700
                                  .withOpacity(0.6), //else return green colour
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Text(
                        ranking.toString(), //display ranking as text
                        style: TextStyle(
                          fontFamily: 'Roboto Bold',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: ranking.toString().length == 1
                            ? 75 //If ranking is 1 digit, return sizedbox of width 75 for spacing between ranking and circle avater
                            : 69), //else if ranking is 2 digit or more, return sizedbox of width 70 for spacing between ranking and circle avatar

                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('${currentUser.profilePic}'),
                      radius: 15,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 5, //space between circle avatar and username
                    ),
                    Text(
                      '${currentUser.username}',
                      style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                    ),
                    Spacer(), //space out username and hero points
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 48), //shift heropoints 48px from the right
                      child: Text(
                        '${currentUser.heroPoints.toString()}',
                        style:
                            TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (ctx, i) {
              return Divider(
                height: 15,
                color: Colors.transparent, //make divider invisible
              );
            },
            itemCount: itemCount,
          );
  }
}
