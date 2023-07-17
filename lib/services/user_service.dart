import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planethero_application/models/user.dart';

import '../global/current_user_singleton.dart';

class UserService {
  Future<int> getLoggedInUserObjectRanking() async {
    final currentUser = CurrentUserSingleton()
        .currentUser; // Access the currentUser from the singleton

    // get the reference to the 'users' collection in Firestore
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');

    //Get the snapshot of all documents in the 'users' collection
    QuerySnapshot snapshot = await usersRef.get();

    //Extract the user data from the snapshot and convert it to a list of users
    List<UserObject> userObjects =
        snapshot.docs.map((doc) => UserObject.fromJson(doc)).toList();

    // Sort the userObjects list based on hero points in descending order
    userObjects.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

    // Find the index of the logged-in UserObject
    int loggedInUserObjectIndex =
        userObjects.indexWhere((user) => user.uid == currentUser.uid);

    // Add 1 to the index to get the ranking since lists start with index 0 and not 1
    int ranking = loggedInUserObjectIndex + 1;

    return ranking;
  }

  // get top 10 users for leaderboard
  Future<List<UserObject>> getLeaderboard() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .orderBy('heroPoints', descending: true)
        .limit(10)
        .get();

    List<UserObject> topUsers = snapshot.docs.map((doc) {
      return UserObject(
        uid: doc['uid'],
        username: doc['username'],
        email: doc['email'],
        password: doc['password'],
        profilePic: doc['profilePic'],
        actionsCompleted: doc['actionsCompleted'],
        heroPoints: doc['heroPoints'],
      );
    }).toList(); //return all elements or docs in the snapshot into a list

    return topUsers;
  }

  updateUsername(uid, username) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'username': username});
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  changePassword({email, oldPassword, newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    await currentUser!.reauthenticateWithCredential(cred);
    currentUser!.updatePassword(newPassword);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update({'password': newPassword});
  }

  addPoints(uid, addedPoints, actionsCompleted) {
    return FirebaseFirestore.instance.collection('users').doc(uid).update(
        {'heroPoints': addedPoints, 'actionsCompleted': actionsCompleted});
  }
}
