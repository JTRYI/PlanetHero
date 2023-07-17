import 'package:flutter/material.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/services/comment_service.dart';
import 'package:planethero_application/widgets/edit-comment-modal.dart';
import '../global/current_user_singleton.dart';
import '../models/comment.dart';

class ListComments extends StatefulWidget {
  final HeroAction selectedAction;

  //Constructor the widget, pass in selectedAction as the parameter
  ListComments(this.selectedAction);

  @override
  State<ListComments> createState() => _ListCommentsState();
}

class _ListCommentsState extends State<ListComments> {
  //declare comments service
  CommentService commentService = CommentService();

  final currentUser = CurrentUserSingleton()
      .currentUser; 
 // Access the currentUser from the singleton
  @override
  Widget build(BuildContext context) {
    // //declare commments provider
    // AllComments allComments = Provider.of<AllComments>(context);
    // //declare the users provider
    // AllUsers usersList = Provider.of<AllUsers>(context);

  
    //method to remove Comment with alert dialog
    void removeComment(id, context) {
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Confirmation!',
                style: TextStyle(fontFamily: 'Roboto Bold'),
              ),
              content: const Text(
                'Are you sure you want to delete?',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      commentService.removeComment(id);
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

    // Stream of comments for the selected action
    Stream<List<Comment>> actionCommentsStream = widget.selectedAction != null
        ? commentService.getCommentsForAction(widget.selectedAction.actionTitle)
        : Stream<List<Comment>>.empty();

    return StreamBuilder<List<Comment>>(
        stream: actionCommentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment> actionComments = snapshot.data!;
            return ListView.separated(
              itemBuilder: (ctx, i) {
                Comment currentComment = actionComments[i];
                //check if the comment is added by the user logged in
                bool isCurrentUserComment =
                    currentComment.uid == currentUser.uid;
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
                                    NetworkImage(currentComment.profilePic),
                                radius: 20,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left:
                                      10), //Move username 10px from the avatar
                              child: Text(
                                currentComment.username,
                                style: TextStyle(
                                    fontFamily: 'Roboto Bold', fontSize: 14),
                              ),
                            ),
                            Spacer(), //Space out username and edit icon
                            // Show the edit and delete icons only if the current user added the comment
                            if (isCurrentUserComment)
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EditCommentModal(currentComment),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.greenAccent.shade700,
                                  )),
                            if (isCurrentUserComment)
                              SizedBox(
                                width: 2,
                              ), //Space between the edit icon and delete icon
                            if (isCurrentUserComment)
                              IconButton(
                                  onPressed: () {
                                    removeComment(currentComment.id, context);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 15,
                                    color: Colors.red,
                                  ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ), //Space between avatar and comment
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            currentComment.comment,
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ), // Spacing between comments and timestamp
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${currentComment.timeStamp}',
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 10),
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
