import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserObject {
  //declare the variables
  String uid;
  String username;
  String email;
  String password;
  String profilePic;
  int actionsCompleted;
  int heroPoints;

  //Constructor
  UserObject(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      required this.profilePic,
      required this.actionsCompleted,
      required this.heroPoints});

  factory UserObject.fromJson(DocumentSnapshot snapshot) {
    return UserObject(
      uid: snapshot.id,
      username: snapshot['username'] ?? '',
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      profilePic: snapshot['profilePic'] ?? '',
      actionsCompleted: snapshot['actionsCompleted'] ?? 0,
      heroPoints: snapshot['heroPoints'] ?? 0,
    );
  }
}
