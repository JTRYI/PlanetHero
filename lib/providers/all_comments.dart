import 'package:flutter/material.dart';

import '../models/comment.dart';

class AllComments with ChangeNotifier {
  //Populate a list of Comments
  List<Comment> allComments = [
    Comment(
        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        'Tester',
        'My first action completed! I am so happy!',
        'Bring Recycle Bags',
        DateTime.now().toString()),
    Comment(
        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        'Tester2',
        'My first action completed! I am so happy happy!',
        'Air-Dry Clothes After Washing',
        DateTime.now().toString()),
    Comment(
        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        'Tester3',
        'Action is actually easy to do. I recommend collecting bamboos to help hang your clothes for those that does not want to buy the rods.',
        'Air-Dry Clothes After Washing',
        DateTime.now().toString()),
    Comment(
        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        'Tester4',
        'I did it! Gonna keep it up and claim my points everyday!',
        'Air-Dry Clothes After Washing',
        DateTime.now().toString()),
    Comment(
        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        'Tester4',
        'Second Day! I did it again! Woohoo!',
        'Air-Dry Clothes After Washing',
        DateTime.now().toString()),
  ];

  //function to get all comments
  List<Comment> getComments() {
    return allComments;
  }

  //function to add comments
  void addComment(profilePic, username, comment, action, timeStamp) {
    allComments.insert(
        0, Comment(profilePic, username, comment, action, timeStamp));

    notifyListeners();
  }

  //function to remove comment
  void removeComment(Comment comment) {
    allComments.remove(comment);
    notifyListeners();
  }

  //function to update comment
  void editComment(Comment comment, String newComment) {
    comment.comment = newComment; //update the comment property
    comment.timeStamp = DateTime.now().toString();

    notifyListeners();
  }
}
