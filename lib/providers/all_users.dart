import 'package:flutter/material.dart';
import 'package:planethero_application/services/user_service.dart';

import '../models/user.dart';

class AllUsers with ChangeNotifier {
  //Initialise an empty list of users
  List<UserObject> _users = [];

  List<UserObject> get users => [..._users]; // Return a copy of the users list

  //declare User Service
  final UserService userService = UserService();

  Future<void> fetchTopUsers() async {
    try {
      List<UserObject> topUsers = await userService.getLeaderboard();

      _users = topUsers; // Update the users list with the fetched data
      notifyListeners(); // Notify the listeners that the state has changed
    } catch (error) {
      // Handle any errors that occurred during the fetch process
      print('Error fetching top users: $error');
    }
  }

  // //Store the logged in UserObject
  // UserObject? loggedInUserObject;

  // //function to print allUserObjects List
  // void printUserObjects() {
  //   allUserObjects.forEach((UserObject) {
  //     debugPrint(
  //         'username: ${UserObject.username}, Email: ${UserObject.email}, Password: ${UserObject.password}, Actions Completed: ${UserObject.actionsCompleted}, Hero Points: ${UserObject.heroPoints}');
  //   });
  // }

  // //function to register UserObject
  // void registerUserObject(
  //     username, email, password, profilePic, actionsCompleted, heroPoints) {
  //   //insert UserObject object into index 0 of the UserObjects list

  //   profilePic = 'https://cdn-icons-png.flaticon.com/128/9797/9797462.png';
  //   actionsCompleted = 0;
  //   heroPoints = 0;

  //   allUserObjects.insert(
  //       0,
  //       UserObject(
  //           username: username,
  //           email: email,
  //           password: password,
  //           profilePic: profilePic,
  //           actionsCompleted: actionsCompleted,
  //           heroPoints: heroPoints, uid: ''));

  //   notifyListeners();
  // }

  // void loginUserObject(loggedEmail, loggedPassword, BuildContext context) {
  //   //check if the provided email and password match a registered UserObject
  //   bool isUserObjectFound = false;

  //   for (UserObject UserObject in allUserObjects) {
  //     if (UserObject.email == loggedEmail && UserObject.password == loggedPassword) {
  //       isUserObjectFound = true;
  //       loggedInUserObject = UserObject; //set the logged-in UserObject
  //       //break from the for loop
  //       break;
  //     }
  //   }

  //   // if true, UserObject is found or all credentials are keyed correctly
  //   if (isUserObjectFound) {
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (_) => ParentScreen()));
  //     debugPrint('Login Successful!');
  //   } else {
  //     // UserObject is not found or credentials are not correct
  //     debugPrint('Login Failed!');
  //     //show a snackbar of failed authentication
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Please enter a valid email address and password!'),
  //     ));
  //   }
  // }

  // int getLoggedInUserObjectRanking() {
  //   //create a copy of the allUserObjects list
  //   List<UserObject> sortedUserObjects = List.from(allUserObjects);

  //   //sort the list based on hero points in descending order
  //   sortedUserObjects.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

  //   //find index of logged-in UserObject
  //   int loggedInUserObjectIndex =
  //       sortedUserObjects.indexWhere((UserObject) => UserObject == loggedInUserObject);

  //   //Add 1 to the index to get ranking since lists start with index 0 and not 1
  //   int ranking = loggedInUserObjectIndex + 1;

  //   return ranking;
  // }

  // //create a leaderboard list in descending order
  // List<UserObject> getLeaderboard() {
  //   //create a copy of the allUserObjects list
  //   List<UserObject> sortedUserObjects = List.from(allUserObjects);

  //   //sort the list based on hero points in descending order
  //   sortedUserObjects.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

  //   return sortedUserObjects;
  // }

  // void addPoints(
  //     UserObject loggedInUserObject, int addedPoints, BuildContext context) {
  //   loggedInUserObject.heroPoints += addedPoints;
  //   loggedInUserObject.actionsCompleted += 1;
  //   notifyListeners();
  // }
}
