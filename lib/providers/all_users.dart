import 'package:flutter/material.dart';

import '../models/User.dart';

class AllUsers with ChangeNotifier {
  //create list to store users
  List<User> allUsers = [];

  //function to get all users
  List<User> getUsers() {
    return allUsers;
  }

  //function to print allUsers List
  void printUsers() {
    allUsers.forEach((User) {
      debugPrint(
          'Username: ${User.username}, Email: ${User.email}, Password: ${User.password}, Actions Completed: ${User.actionsCompleted}, Hero Points: ${User.heroPoints}');
    });
  }

  //function to register user
  void registerUser(username, email, password, actionsCompleted, heroPoints) {
    //insert User object into index 0 of the users list

    actionsCompleted = 0;
    heroPoints = 0;

    allUsers.insert(
        0,
        User(
            username: username,
            email: email,
            password: password,
            actionsCompleted: actionsCompleted,
            heroPoints: heroPoints));

    notifyListeners();
  }

  void loginUser(loggedEmail, loggedPassword) {
    //check if the provided email and password match a registered user
    bool isUserFound = false;

    for (User user in allUsers) {
      if (user.email == loggedEmail && user.password == loggedPassword) {
        isUserFound = true;
        //break from the for loop
        break;
      }
    }

    // if true, user is found or all credentials are keyed correctly
    if (isUserFound) {
      debugPrint('Login Successful!');
    } else {
      // User is not found or credentials are not correct
      debugPrint('Login Failed!');
    }
  }
}
