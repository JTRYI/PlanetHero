import 'package:flutter/material.dart';
import 'package:planethero_application/providers/all_users.dart';
import 'package:planethero_application/screens/actions_screen.dart';
import 'package:planethero_application/screens/bookmarks_screen.dart';
import 'package:planethero_application/screens/leaderboard_screen.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/screens/settings_screen.dart';
import 'package:planethero_application/widgets/bottom-navbar.dart';
import 'package:planethero_application/widgets/user-stats.dart';
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
        debugShowCheckedModeBanner: false,
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

    return Scaffold(
        backgroundColor: background,
        bottomNavigationBar: CustomBottomNavigationBar(
          initialIndex: initialIndex,
        ),
        body: SingleChildScrollView(
          child: Stack(
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
                        end: Alignment.bottomCenter, //last or second color at the bottom of the container
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
                          fontFamily: 'Roboto Bold',
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                          height:
                              40), // add 40 px of space between the users name and the box below
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserStats(), // user statistics widget
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Browse Actions",
                              style: TextStyle(
                                fontFamily: 'Roboto Bold',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          SizedBox(
                            //Leave 15 px of space between the stats and 'Browse Actions' Text
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                70, //Gets the size of the screen and minus 70
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  15), // Rounded corners for the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), //Shadow color with opacity
                                  blurRadius:
                                      20, //Amount of blur for the shadow
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      15), // Rounded corners for the image
                                  child: Image.asset(
                                    'images/browse-actions-img.jpg',
                                    fit: BoxFit
                                        .cover, // Scale the image to cover the entire container
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 30,
                                      left:
                                          15), //Move text 30px from top of container and 15px from left
                                  child: Text(
                                    'Start Now!',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'Roboto Bold'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ), // Space between Actions container and Bookmarks Text
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Bookmarks",
                              style: TextStyle(
                                fontFamily: 'Roboto Bold',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            //Leave 15 px of space between the Text and Library Image
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  15), // Rounded corners for the container
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), //Shadow color with opacity
                                  blurRadius:
                                      20, //Amount of blur for the shadow
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15), // Rounded corners for the image
                              child: Image.asset(
                                'images/library.jpg',
                                fit: BoxFit
                                    .cover, // Scale the image to cover the entire container
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), //Shadow color with opacity
                                  blurRadius:
                                      20, //Amount of blur for the shadow
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(33),
                              child: Text(
                                "'Don't Just Think, You Have To Take Action!'",
                                style: TextStyle(
                                    fontFamily: 'Roboto Bold',
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ) //Leave 20px of spacing from navbar
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
