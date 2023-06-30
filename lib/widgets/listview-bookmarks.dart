import 'package:flutter/material.dart';
import 'package:planethero_application/models/bookmark.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/providers/all_actions.dart';
import 'package:planethero_application/providers/all_bookmarks.dart';
import 'package:planethero_application/providers/all_users.dart';
import 'package:planethero_application/screens/clicked_action_screen.dart';
import 'package:planethero_application/screens/comments_screen.dart';
import 'package:provider/provider.dart';

class ListBookmarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //declare Bookmarks provider
    AllBookmarks allBookmarks = Provider.of<AllBookmarks>(context);

    //declare User provider
    AllUsers allUsers = Provider.of<AllUsers>(context);

    //Get logged in user's username
    String loggedUsername = allUsers.loggedInUser!.username;

    //create a new list to store logged in user bookmarks only
    List<Bookmark> userBookmarks = allBookmarks
        .getBookmarks()
        .where((bookmark) =>
            bookmark.username ==
            loggedUsername) //if the bookmark in list username = logged in user's username, add to new list
        .toList();

    //method to remove Bookmark with alert dialog
    void removeBookmark(int index, context) {
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
                      if (index >= 0 && index < userBookmarks.length) {
                        Bookmark bookmarkToRemove = userBookmarks[index];
                        if (bookmarkToRemove.username == loggedUsername) {
                          allBookmarks.removeBookmark(bookmarkToRemove);
                        }
                      }
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
                borderRadius:
                    BorderRadius.circular(15), // Rounded corners for the image
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
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
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
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
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
                Container(
                    height: 15, //set height of text button to be 15px
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade700.withOpacity(
                          0.5), //setting background colour with reduced opacity
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.greenAccent.shade700),
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Claim Now',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold',
                              fontSize: 12,
                              color: Colors.white),
                        ))),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: IconButton(
                      onPressed: () {
                        removeBookmark(i, context);
                      },
                      icon: Icon(Icons.bookmark_remove,
                          size: 15, color: Colors.greenAccent.shade400)),
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
  }
}
