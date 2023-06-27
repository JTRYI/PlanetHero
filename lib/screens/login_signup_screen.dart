// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:planethero_application/widgets/login-signup-form.dart';

// Background color
String hexColor = "#f2f4f3";
Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class LoginSignupScreen extends StatefulWidget {
  // Declare route name
  static String routeName = '/login-signup-screen';

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background, // Set the background color
        child: LoginSignupForm(),
      ),
    );
  }
}
