import 'package:flutter/material.dart';
import 'package:planethero_application/models/comment.dart';
import 'package:provider/provider.dart';
import 'package:planethero_application/providers/all_comments.dart';
import '../providers/all_users.dart';

class EditCommentModal extends StatefulWidget {
  final Comment currentComment;

  //Constructor the widget, pass in selectedAction as the parameter
  EditCommentModal(this.currentComment);

  @override
  State<EditCommentModal> createState() => _EditCommentModalState();
}

class _EditCommentModalState extends State<EditCommentModal> {
  //declare the variables
  String? updatedComment;
  String? initialComment;

  @override
  void initState() {
    super.initState();
    initialComment = widget.currentComment.comment; //get the initial comment from the widget parameter which is currentComment
  }

  //declare the form state
  var commentForm = GlobalKey<FormState>();

  //method to save comment form
  void saveComment(AllUsers usersList, AllComments allComments) {
    //check on validation
    bool isValid = commentForm.currentState!.validate();

    Comment currentComment = widget.currentComment;
    if (isValid) {
      commentForm.currentState!.save();
      String? updatedText = updatedComment; // Handle nullability
      if (updatedText != null) {
        allComments.editComment(currentComment, updatedText);
        //hide the keyboard
        FocusScope.of(context).unfocus();
        //reset the form
        commentForm.currentState!.reset();
        Navigator.pop(context);
        //show a snackbar of comment added successfully
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Comment edited successfully!'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //declare the users provider
    AllUsers usersList = Provider.of<AllUsers>(context);

    // Access the comments provider using Provider.of with the context
    AllComments allComments = Provider.of<AllComments>(context);

    // Create a TextEditingController and set the initial value
    TextEditingController usernameController =
        TextEditingController(text: usersList.loggedInUserObject!.username);

    @override
    void dispose() {
      // Dispose of the controller object
      usernameController
          .dispose(); // Dispose the username text field controller
      super.dispose(); // Call the super class's dispose method
    }

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade700),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade700),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    OutlineInputBorder currentBorder = enabledBorder;

    return AlertDialog(
      title: Center(
        child: Text(
          'Edit Comment',
          style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Column(
            children: [
              Form(
                key: commentForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ), //Space between username title and text form field
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade100,
                      ),
                      child: TextFormField(
                        controller: usernameController,
                        enabled: false,
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                        decoration: InputDecoration(
                          border: currentBorder,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          20, //Space between text form field and comment title
                    ),
                    Text(
                      'Comment',
                      style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 14),
                    ),
                    SizedBox(
                      height: 15,
                    ), //Space between comment title and text form field
                    TextFormField(
                      initialValue: initialComment,
                      maxLines:
                          4, // allow the TextField to have a space of 4 lines
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a comment.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        updatedComment = value as String;
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ), //Space between comment text field and buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                      fontFamily: 'Roboto Bold',
                                      color: Colors.white),
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
                              border: Border.all(
                                  color: Colors.greenAccent.shade700),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  saveComment(usersList, allComments);
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontFamily: 'Roboto Bold',
                                      color: Colors.white),
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
