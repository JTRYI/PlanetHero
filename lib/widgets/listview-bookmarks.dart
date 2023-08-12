import 'package:flutter/material.dart';
import 'package:planethero_application/models/bookmark.dart';
import 'package:planethero_application/services/bookmark_service.dart';
import 'package:planethero_application/services/user_service.dart';
import '../global/current_user_singleton.dart';

class ListBookmarks extends StatefulWidget {
  @override
  State<ListBookmarks> createState() => _ListBookmarksState();
}

class _ListBookmarksState extends State<ListBookmarks> {
  @override
  Widget build(BuildContext context) {
    //declare User service
    UserService userService = UserService();

    //declare bookmark service
    BookmarkService bookmarkService = BookmarkService();

    // Access the currentUser from the singleton
    final currentUser = CurrentUserSingleton().currentUser;

    int userPoints = currentUser.heroPoints;

    //method to remove Bookmark with alert dialog
    void removeBookmark(bid, context) {
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Confirmation!',
                style: TextStyle(fontFamily: 'Roboto Bold'),
              ),
              content: const Text(
                'Are you sure you want to remove this bookmark?',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      bookmarkService.removeBookmark(bid);
                      Navigator.of(context).pop();
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
    void addPoints(addedPoints) {
      //variables below for adding points
      String uid = currentUser.uid;
      int actionsCompleted = currentUser.actionsCompleted += 1;

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
                          setState(() {
                            currentUser.heroPoints = addedPoints;
                          });
                          userService.addPoints(
                              uid, addedPoints, actionsCompleted);
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

    //Stream of bookmarks for particular user
    Stream<List<Bookmark>> userBookmarkStream =
        bookmarkService.getUserBookmarks(currentUser.uid);

    return StreamBuilder<List<Bookmark>>(
        stream: userBookmarkStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Bookmark> userBookmarks = snapshot.data!;
            return ListView.separated(
              itemBuilder: (ctx, i) {
                Bookmark currentBookmark = userBookmarks[i];
                return Column(
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
                          currentBookmark.imageUrl,
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
                        '${currentBookmark.actionTitle}',
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
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 10),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Claim Points',
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            'Remove from Bookmarks',
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 10),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ), //Give 12px of spacing from the left, aligning text under 'Hero Points'
                          child: Text(
                            '${currentBookmark.heroPoints}',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.greenAccent.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: currentBookmark.heroPoints
                                          .toString()
                                          .length ==
                                      1
                                  ? 20
                                  : (currentBookmark.heroPoints
                                              .toString()
                                              .length ==
                                          2)
                                      ? 15
                                      : 2),
                          child: Container(
                              height: 30, //set height of text button to be 15px
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.shade700.withOpacity(
                                    0.5), //setting background colour with reduced opacity
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.greenAccent.shade700),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    addPoints(userPoints +=
                                        currentBookmark.heroPoints);
                                  },
                                  child: Text(
                                    'Claim Now',
                                    style: TextStyle(
                                        fontFamily: 'Roboto Bold',
                                        fontSize: 12,
                                        color: Colors.white),
                                  ))),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: IconButton(
                              onPressed: () {
                                removeBookmark(currentBookmark.bid, context);
                              },
                              icon: Icon(Icons.bookmark_remove,
                                  size: 15,
                                  color: Colors.greenAccent.shade400)),
                        )
                      ],
                    )
                  ],
                );
              },
              separatorBuilder: (ctx, i) {
                return const Divider(
                  height: 20, //20px of space between the actions
                  color: Colors.transparent, //make it invisible
                );
              },
              itemCount: userBookmarks.length,
            );
          } else if (snapshot.hasError) {
            //handle the error case
            return Text('Error: ${snapshot.error}');
          } else {
            // Handle the loading state
            return Center(child: const CircularProgressIndicator());
          }
        });
  }
}
