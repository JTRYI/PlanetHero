import 'package:flutter/material.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/widgets/update-password-form.dart';
import 'package:planethero_application/widgets/update-user-form.dart';

import '../services/auth_service.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class SettingScreen extends StatefulWidget {
  //declare route name
  static String routeName = '/settings';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthService authService = AuthService();

  //function to logout
  logOut(context) {
    return authService.logOut().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Logout Successfully!'),
      ));
    }).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(
                35), //column is spaced out 35px from the container on all sides
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .end, //shift all the items in the row to the end of row
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right:
                              40), //40px of spacing between 'Hero Settings' text and logout button
                      child: Text(
                        'Hero Settings',
                        style:
                            TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
                      ),
                    ),
                    Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(
                                0.5), //setting background colour with reduced opacity
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red)),
                        child: TextButton(
                            onPressed: () {
                              logOut(context);
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontFamily: 'Roboto Bold',
                                  fontSize: 12,
                                  color: Colors.white),
                            ))),
                  ],
                ),
                SizedBox(
                  height: 30,
                ), //space between 'Hero Setting' title and form below
                UpdateUserForm(),
                SizedBox(
                  height: 25,
                ), //space between Update user form and update password form
                UpdatePasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
