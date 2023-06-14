import 'package:flutter/material.dart';
import 'package:planethero_application/providers/all_users.dart';
import 'package:planethero_application/screens/actions_screen.dart';
import 'package:planethero_application/screens/bookmarks_screen.dart';
import 'package:planethero_application/screens/leaderboard_screen.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/screens/settings_screen.dart';
import 'package:planethero_application/widgets/bottom-navbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllUsers>(
          create: (ctx) => AllUsers(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LoginSignupScreen(),
        routes: {
          MainScreen.routeName: (_) {
            return MainScreen();
          },
          LoginSignupScreen.routeName: (_) {
            return LoginSignupScreen();
          },
          ActionScreen.routeName: (_) {
            return ActionScreen();
          },
          BookmarkScreen.routeName: (_) {
            return BookmarkScreen();
          },
          LeaderboardScreen.routeName: (_) {
            return LeaderboardScreen();
          },
          SettingScreen.routeName: (_) {
            return SettingScreen();
          }
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    //for bottom nav bar
    final int initialIndex =
        ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    //declare the provider
    AllUsers usersList = Provider.of<AllUsers>(context);

    //Get logged-in user ranking
    int loggedInUserRanking = usersList.getLoggedInUserRanking();

    return Scaffold(
        backgroundColor: background,
        bottomNavigationBar: CustomBottomNavigationBar(
          initialIndex: initialIndex,
        ),
        body: Stack(
          children: [
            //creating a container for the background
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height /
                  2, //background takes up half of the screen
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment
                          .topCenter, //first colour at the top of the container
                      end: Alignment
                          .bottomCenter, //last or second color at the bottom of the container
                      colors: [
                        Colors.greenAccent.shade400,
                        Colors.greenAccent.shade200
                      ]), //Background colors of the screen
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          150), //giving a circular curve at both the left and right of the background
                      bottomRight: Radius.circular(150))),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15), //padding of 15 px from the top
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Users profile pic
                    Icon(Icons.account_circle, size: 80),
                    SizedBox(
                        height:
                            10), //add 10 px of space between user profile and users name

                    // Users username
                    Text(
                      "Welcome ${usersList.loggedInUser?.username}!",
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                        height:
                            20), // add 20 px of space between the users name and the box below
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 225,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // rows will be spaced evenly in the container
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      20), //space at the left of the container and image
                              Image.asset('images/Actions.png'),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        15), //15px of space between text and image
                                child: Text(
                                  'Actions Completed',
                                  style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      125), //125px of space between the previous text and next text
                              Text(
                                '${usersList.loggedInUser?.actionsCompleted}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
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
                                      fontFamily: 'Arial',
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 172,
                              ),
                              Text(
                                "${usersList.loggedInUser?.heroPoints}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
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
                                      fontFamily: 'Arial',
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 195,
                              ),
                              Text(
                                loggedInUserRanking.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
