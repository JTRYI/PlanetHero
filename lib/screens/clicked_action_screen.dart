import 'package:flutter/material.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/providers/all_bookmarks.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/all_users.dart';
import 'login_signup_screen.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class ClickedAction extends StatefulWidget {
  //declare route name
  static String routeName = '/clicked-action-screen';

  @override
  State<ClickedAction> createState() => _ClickedActionState();
}

class _ClickedActionState extends State<ClickedAction> {
  @override
  Widget build(BuildContext context) {
    // retrieve the arguments from actions screen
    HeroAction selectedAction =
        ModalRoute.of(context)?.settings.arguments as HeroAction;

    //declare the bookmarks provider
    AllBookmarks allBookmarks = Provider.of<AllBookmarks>(context);

    //declare the users provider
    AllUsers allUsers = Provider.of<AllUsers>(context);

    //declare the variables
    String username = allUsers.loggedInUserObject!
        .username; //'!' means loggedInUser is non-null, allows me to access the username property of the non-null value.
    String imageUrl = selectedAction.imageUrl;
    String actionTitle = selectedAction.actionTitle;
    int heroPoints = selectedAction.heroPoints;

    //create variable for logged in user
    UserObject? loggedUser = allUsers.loggedInUserObject;

    //function to add to bookmarks
    void addToBookmark() {
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Confirmation!',
                style: TextStyle(fontFamily: 'Roboto Bold'),
              ),
              content: const Text(
                'Are you sure you want to add to bookmarks?',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      allBookmarks.addBookmark(
                          username, imageUrl, actionTitle, heroPoints);
                      //show a snackbar of bookmark added successfully
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Action added to Bookmarks!'),
                      ));
                      Navigator.pop(context);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'))
              ],
            );
          });
    }

    //function to add points
    void addPoints(loggedUser, heroPoints, context) {
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Well Done!',
                style: TextStyle(fontFamily: 'Roboto Bold'),
              ),
              content: const Text(
                'Thanks for helping to build a sustainable future! Keep it up!',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
              actions: [
                Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(
                            0.5), //setting background colour with reduced opacity
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold', color: Colors.white),
                        ))),
                SizedBox(
                  width: 20,
                ),
                Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade700.withOpacity(
                          0.5), //setting background colour with reduced opacity
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.greenAccent.shade700),
                    ),
                    child: TextButton(
                        onPressed: () {
                          allUsers.addPoints(loggedUser, heroPoints, context);
                          //show a snackbar of bookmark added successfully
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Points Added!'),
                          ));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Claim Points',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold', color: Colors.white),
                        ))),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          '${selectedAction.actionTitle}',
          style: TextStyle(
            fontFamily: 'Roboto Bold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        15), // Rounded corners for the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.1), //Shadow color with opacity
                        blurRadius: 20, //Amount of blur for the shadow
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Rounded corners for the image
                    child: Image.network(
                      selectedAction.imageUrl,
                      fit: BoxFit
                          .cover, // Scale the image to cover the entire container),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ), //Space between image and title
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${selectedAction.actionTitle}',
                    style: TextStyle(
                      fontFamily: 'Roboto Bold',
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ), //Space between title and next row
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left:
                              12), //Give 12px of spacing from the left, aligning text under the title
                      child: Text(
                        'Hero Points',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                      ),
                    ),
                    Spacer(), //give space between 'Hero Points' and 'Difficulty'
                    Padding(
                      padding: const EdgeInsets.only(right: 190.0),
                      child: Text(
                        'Difficulty',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ), //Give 12px of spacing from the left, aligning text under 'Hero Points'
                      child: Text(
                        '${selectedAction.heroPoints}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.greenAccent.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: selectedAction.heroPoints.toString().length ==
                                  1
                              ? 198 //If hero points is 1 digit, return padding of 198px from the right
                              : (selectedAction.heroPoints.toString().length ==
                                      2
                                  ? 191 //else if hero points is 2 digit, return padding of 191px from the right
                                  : 198)), //else if neither 1 or 2 digit, return padding of 198px from the right
                      child: Text(
                        '${selectedAction.difficulty}',
                        style: TextStyle(
                            fontFamily: 'Roboto Bold',
                            fontSize: 10,
                            color: getColorForDifficulty(
                                selectedAction.difficulty)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ), //Space between last row and divider
                Divider(
                  height: 15,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10,
                ), //Space between divider and icons circle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors
                              .click, // Set the cursor to a clickable cursor
                          child: GestureDetector(
                            onTap: () {
                              addToBookmark();
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, //Colour of circle
                                border: Border.all(
                                  color: Colors.greenAccent
                                      .shade700, //Color for border or outline of circle
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                //Icon inside circle
                                child: Icon(
                                  Icons.bookmark_add,
                                  color: Colors.greenAccent.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ), //Space between icon circle and texts
                        Column(
                          //Column to leave a line for the texts
                          children: [
                            Text(
                              'Save to',
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 8),
                            ),
                            Text(
                              'Bookmarks',
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 8),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              addPoints(loggedUser, heroPoints, context);
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, //Colour of circle
                                border: Border.all(
                                  color: Colors.greenAccent
                                      .shade700, //Color for border or outline of circle
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                //Icon inside circle
                                child: Icon(
                                  Icons.task_outlined,
                                  color: Colors.greenAccent.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ), //Space between icon circle and texts
                        Column(
                          //Column to leave a line for the texts
                          children: [
                            Text(
                              'Achieved!',
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 8),
                            ),
                            Text(
                              '(Click to Claim Points)',
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ), //Space between icons circle and divider
                Divider(
                  height: 15,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 20,
                ), //Space between divider and description title
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text('Description',
                      style: TextStyle(
                        fontFamily: 'Roboto Bold',
                        fontSize: 20,
                      )),
                ),
                SizedBox(
                  height: 20,
                ), //space between description title and text
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '${selectedAction.description}',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 20,
                ) //Give cusion if there is a scroll
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//function to show what color base on the difficulty of action
getColorForDifficulty(String difficulty) {
  if (difficulty == 'Easy') {
    return Colors.greenAccent.shade400;
  } else if (difficulty == 'Medium') {
    return Colors.orange.shade400;
  } else if (difficulty == 'Hard') {
    return Colors.red;
  }
}
