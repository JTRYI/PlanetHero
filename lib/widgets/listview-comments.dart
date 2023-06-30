import 'package:flutter/material.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/providers/all_comments.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';

class ListComments extends StatelessWidget {
  final HeroAction selectedAction;

  //Constructor the widget, pass in selectedAction as the parameter
  ListComments(this.selectedAction);

  @override
  Widget build(BuildContext context) {
    //declare commments provider
    AllComments allComments = Provider.of<AllComments>(context);
    List<Comment> actionComments = selectedAction !=
            null //Create a new list called actionComments to store comments for the clicked action only
        ? allComments
            .getComments()
            .where((comment) =>
                comment.action ==
                selectedAction
                    .actionTitle) //If the comment has the same action title as the selected action
            .toList() // title, add them to the list
        : []; //else, no comment matches or the actions has no comments, return a empty list

    return ListView.separated(
      itemBuilder: (ctx, i) {
        Comment currentComment = actionComments[i];
        return Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(
                10), //Give 10px spacing from all sides for the column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5,
                          left:
                              10), //Move avatar 5px from the top of column and 10px from the left
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${currentComment.profilePic}'),
                        radius: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10), //Move username 10px from the avatar
                      child: Text(
                        '${currentComment.username}',
                        style:
                            TextStyle(fontFamily: 'Roboto Bold', fontSize: 14),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ), //Space between avatar and comment
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${currentComment.comment}',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 10,
                ), // Spacing between comments and timestamp
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${currentComment.timeStamp}',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (ctx, i) {
        return const Divider(
          height: 20, //20px of space between the comments
          color: Colors.transparent, //make it invisible
        );
      },
      itemCount: actionComments.length,
    );
  }
}
