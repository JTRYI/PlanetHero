import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planethero_application/firebase_options.dart';
import 'package:planethero_application/models/user.dart';
import 'package:planethero_application/providers/all_users.dart';
import 'package:planethero_application/screens/actions_screen.dart';
import 'package:planethero_application/screens/bookmarks_screen.dart';
import 'package:planethero_application/screens/clicked_action_screen.dart';
import 'package:planethero_application/screens/comments_screen.dart';
import 'package:planethero_application/screens/leaderboard_screen.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/screens/parent_screen.dart';
import 'package:planethero_application/screens/settings_screen.dart';
import 'package:planethero_application/services/auth_service.dart';
import 'package:planethero_application/widgets/user-stats.dart';
import 'package:provider/provider.dart';

import 'global/current_user_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    runApp(MyApp());
  });
}

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class MyApp extends StatelessWidget {
  //declare Authentication Service
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authService.getAuthUser(),
        builder: (context, snapshot) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AllUsers>(
                create: (ctx) => AllUsers(),
              ),
            ],
            child: FutureBuilder<UserObject?>(
                future: authService.getCurrentUser(),
                builder: (context, usersnapshot) {
                  if (usersnapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while fetching the current user data
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (usersnapshot.hasData) {
                    // Current user data is available
                    UserObject currentUser = usersnapshot.data!;
                    CurrentUserSingleton().currentUser = currentUser;
                    //2 prints below to check if it really got the current user data from firestore
                    print('Username: ${currentUser.username}');
                    print('actionsCompleted: ${currentUser.actionsCompleted}');
                    print('profilepic: ${currentUser.profilePic}');
                    print('uid: ${currentUser.uid}');
                  }
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        primarySwatch: Colors.green,
                      ),
                      home: // use if else to route the landing page
                          snapshot.connectionState == ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : snapshot.hasData
                                  ? ParentScreen()
                                  : LoginSignupScreen(),
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
                        },
                        ClickedAction.routeName: (_) {
                          return ClickedAction();
                        },
                        CommentsScreen.routeName: (_) {
                          return CommentsScreen();
                        }
                      });
                }),
          );
        });
  }
}

class MainScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/main-screen';

  //declare Authentication Service
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // //declare the provider
    // AllUsers usersList = Provider.of<AllUsers>(context);

    final currentUser = CurrentUserSingleton()
        .currentUser; // Access the currentUser from the singleton

    return Scaffold(
        backgroundColor: background,
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
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                          height:
                              10), //add 10 px of space between user profile and users name

                      // Users username
                      Text(
                        "Welcome ${currentUser.username}!",
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
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (_) => ActionScreen()));
                            },
                            child: Container(
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
