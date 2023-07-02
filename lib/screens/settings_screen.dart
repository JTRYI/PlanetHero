import 'package:flutter/material.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'package:planethero_application/widgets/update-password-form.dart';
import 'package:planethero_application/widgets/update-user-form.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class SettingScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/settings';

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
                              95), //95px of spacing between 'Hero Settings' text and logout button
                      child: Text(
                        'Hero Settings',
                        style:
                            TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
                      ),
                    ),
                    Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(
                                0.5), //setting background colour with reduced opacity
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red)),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(LoginSignupScreen
                                  .routeName); //Logout, go to login signup screen
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontFamily: 'Roboto Bold',
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
