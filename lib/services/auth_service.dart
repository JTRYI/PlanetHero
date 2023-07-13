import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  //register user
  Future<UserCredential> register(email, password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  //login user
  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  //forgot password
  Future<void> forgotPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  //get authenticated user
  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  //logout user
  logOut() {
    return FirebaseAuth.instance.signOut();
  }

  //get current user
  Future<UserObject> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    return UserObject.fromJson(userInfo);
  }
}
