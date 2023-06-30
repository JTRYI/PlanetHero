import 'package:flutter/material.dart';
import 'package:planethero_application/main.dart';
import 'package:planethero_application/screens/parent_screen.dart';

import '../models/user.dart';

class AllUsers with ChangeNotifier {
  //create list to store users and populate it
  List<User> allUsers = [
    User(
        username: 'Tester',
        email: 'tester@gmail.com',
        password: 'password1',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 5,
        heroPoints: 25),
    User(
        username: 'Tester2',
        email: 'tester2@gmail.com',
        password: 'password2',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 10,
        heroPoints: 100),
    User(
        username: 'Tester3',
        email: 'tester3@gmail.com',
        password: 'password3',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 5,
        heroPoints: 50),
    User(
        username: 'Tester4',
        email: 'tester4@gmail.com',
        password: 'password4',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 1,
        heroPoints: 100),
  ];

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
  void registerUser(
      username, email, password, profilePic, actionsCompleted, heroPoints) {
    //insert User object into index 0 of the users list

    profilePic = 'https://cdn-icons-png.flaticon.com/128/9797/9797462.png';
    actionsCompleted = 0;
    heroPoints = 0;

    allUsers.insert(
        0,
        User(
            username: username,
            email: email,
            password: password,
            profilePic: profilePic,
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
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => ParentScreen()));
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
