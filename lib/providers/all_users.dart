import 'package:flutter/material.dart';
import 'package:planethero_application/main.dart';

import '../models/user.dart';

class AllUsers with ChangeNotifier {
  //create list to store users
  List<User> allUsers = [];

  //Store the logged in user
  User? loggedInUser;

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

  void loginUser(loggedEmail, loggedPassword, BuildContext context) {
    //check if the provided email and password match a registered user
    bool isUserFound = false;

    for (User user in allUsers) {
      if (user.email == loggedEmail && user.password == loggedPassword) {
        isUserFound = true;
        loggedInUser = user; //set the logged-in user
        //break from the for loop
        break;
      }
    }

    // if true, user is found or all credentials are keyed correctly
    if (isUserFound) {
      Navigator.of(context).pushNamed(MainScreen.routeName);
      debugPrint('Login Successful!');
    } else {
      // User is not found or credentials are not correct
      debugPrint('Login Failed!');
      //show a snackbar of failed authentication
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email address and password!'),
      ));
    }
  }

  int getLoggedInUserRanking() {
    //create a copy of the allUsers list
    List<User> sortedUsers = List.from(allUsers);

    //sort the list based on hero points in descending order
    sortedUsers.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

    //find index of logged-in user
    int loggedInUserIndex =
        sortedUsers.indexWhere((user) => user == loggedInUser);

    //Add 1 to the index to get ranking since lists start with index 0 and not 1
    int ranking = loggedInUserIndex + 1;

    return ranking;
  }
}
