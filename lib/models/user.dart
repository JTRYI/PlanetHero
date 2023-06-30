import 'package:flutter/material.dart';

class User {
  //declare the variables
  String username;
  String email;
  String password;
  String profilePic;
  int actionsCompleted;
  int heroPoints;

  //Constructor
  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.profilePic,
      required this.actionsCompleted,
      required this.heroPoints});
}
