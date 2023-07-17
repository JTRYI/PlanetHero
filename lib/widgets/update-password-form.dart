import 'package:flutter/material.dart';
import 'package:planethero_application/services/user_service.dart';

import '../global/current_user_singleton.dart';

class UpdatePasswordForm extends StatefulWidget {
  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  //Texts for password form
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPassswordController = TextEditingController();
  TextEditingController confirmNewPassswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller objects

    currentPasswordController
        .dispose(); // Dispose the current password text field controller
    newPassswordController
        .dispose(); // Dispose the new password text field controller
    confirmNewPassswordController
        .dispose(); // Dispose the confirm new password text field controller

    super.dispose(); // Call the super class's dispose method
  }

  @override
  Widget build(BuildContext context) {
    //declare the form state
    var passwordForm = GlobalKey<FormState>();

    // Access the currentUser from the singleton
    final currentUser = CurrentUserSingleton().currentUser;

    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade700),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade700),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    OutlineInputBorder currentBorder = enabledBorder;

    void updatePassword() {
      bool isValid = passwordForm.currentState!.validate();

      String currentPassword = currentPasswordController.text;
      String newPassword = newPassswordController.text;
      String confirmNewPassword = confirmNewPassswordController.text;

      // Declare user service
      UserService userService = UserService();

      if (isValid) {
        if (newPassword == confirmNewPassword) {
          userService
              .changePassword(
            email: currentUser.email,
            oldPassword: currentPassword,
            newPassword: newPassword,
          )
              .then((value) {
            passwordForm.currentState!.reset();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password updated successfully!'),
              ),
            );
          }).catchError((error) {
            String message = error.toString();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          });
        } else {
          // Show a snackbar if new password and confirm new password do not match
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Passwords do not match!'),
            ),
          );
        }
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 335,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
        child: Column(
          children: [
            Center(
                child: Text(
              'Change Password',
              style: TextStyle(
                fontFamily: 'Roboto Bold',
                fontSize: 15,
              ),
            )),
            SizedBox(
              height: 20,
            ), //space between change password title and current password textfield
            Form(
              key: passwordForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Password',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ), //Space between Current password title and text form field
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: currentPasswordController,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        20, //Space between text form field and new password title
                  ),
                  Text(
                    'New Password',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ), //Space between email title and text form field
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: newPassswordController,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        20, //Space between text form field and confirm new password title
                  ),
                  Text(
                    'Confirm New Password',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ), //Space between confirm new password title and text form field
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: confirmNewPassswordController,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ), //Space between confirm new password text field and buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade700.withOpacity(
                                0.5), //setting background colour with reduced opacity
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.greenAccent.shade700),
                          ),
                          child: TextButton(
                              onPressed: () {
                                updatePassword();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontFamily: 'Roboto Bold',
                                    color: Colors.white),
                              ))),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
