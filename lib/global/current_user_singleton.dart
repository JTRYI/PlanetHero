import 'package:planethero_application/models/user.dart';

// Define a singleton class to store the current user information
class CurrentUserSingleton {

   // The instance of the singleton class
  // It is private and can only be accessed within the class
  static final CurrentUserSingleton _singleton = CurrentUserSingleton._internal();
 
  // A property to store the current user information
  late UserObject currentUser;
  
  // Factory constructor to create an instance of the singleton class
  factory CurrentUserSingleton() {
    // Return the singleton instance
    return _singleton;
  }

  // Method to update the profile picture URL in the singleton
  void updateProfilePictureUrl(String url) {
    currentUser.profilePic = url;
  }

  // Private constructor that can only be called from within the class
  CurrentUserSingleton._internal();

}
