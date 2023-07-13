import 'package:flutter/material.dart';


import '../models/user.dart';

class AllUsers with ChangeNotifier {
  //create list to store UserObjects and populate it
  List<UserObject> allUserObjects = [
    UserObject(
        username: 'Tester',
        email: 'tester@gmail.com',
        password: 'password1',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 5,
        heroPoints: 25, uid: ''),
    UserObject(
        username: 'Tester2',
        email: 'tester2@gmail.com',
        password: 'password2',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 10,
        heroPoints: 100, uid: ''),
    UserObject(
        username: 'Tester3',
        email: 'tester3@gmail.com',
        password: 'password3',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 5,
        heroPoints: 50, uid: ''),
    UserObject(
        username: 'Tester4',
        email: 'tester4@gmail.com',
        password: 'password4',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 1,
        heroPoints: 100, uid: ''),
    UserObject(
        username: 'Tester5',
        email: 'tester5@gmail.com',
        password: 'password5',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 2,
        heroPoints: 15, uid: ''),
    UserObject(
        username: 'Tester6',
        email: 'tester6@gmail.com',
        password: 'password6',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 2,
        heroPoints: 105, uid: ''),
    UserObject(
        username: 'Tester7',
        email: 'tester7@gmail.com',
        password: 'password7',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 3,
        heroPoints: 115, uid: ''),
    UserObject(
        username: 'Tester8',
        email: 'tester8@gmail.com',
        password: 'password8',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 1,
        heroPoints: 100, uid: ''),
    UserObject(
        username: 'Tester9',
        email: 'tester9@gmail.com',
        password: 'password9',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 3,
        heroPoints: 115, uid: ''),
    UserObject(
        username: 'Tester10',
        email: 'tester10@gmail.com',
        password: 'password10',
        profilePic: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        actionsCompleted: 1,
        heroPoints: 100, uid: ''),
  ];

  //Store the logged in UserObject
  UserObject? loggedInUserObject;

  //function to get all UserObjects
  List<UserObject> getUserObjects() {
    return allUserObjects;
  }

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

  int getLoggedInUserObjectRanking() {
    //create a copy of the allUserObjects list
    List<UserObject> sortedUserObjects = List.from(allUserObjects);
    
    //sort the list based on hero points in descending order
    sortedUserObjects.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

    //find index of logged-in UserObject
    int loggedInUserObjectIndex =
        sortedUserObjects.indexWhere((UserObject) => UserObject == loggedInUserObject);

    //Add 1 to the index to get ranking since lists start with index 0 and not 1
    int ranking = loggedInUserObjectIndex + 1;

    return ranking;
  }

  //create a leaderboard list in descending order
  List<UserObject> getLeaderboard() {
    //create a copy of the allUserObjects list
    List<UserObject> sortedUserObjects = List.from(allUserObjects);

    //sort the list based on hero points in descending order
    sortedUserObjects.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));

    return sortedUserObjects;
  }

  void addPoints(UserObject loggedInUserObject, int addedPoints, BuildContext context) {
    loggedInUserObject.heroPoints += addedPoints;
    loggedInUserObject.actionsCompleted += 1;
    notifyListeners();
  }

}
