import 'package:flutter/material.dart';

class UpdatePasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //declare the form state
    var passwordForm = GlobalKey<FormState>();

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
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
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
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a email.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
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
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
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
                              onPressed: () {},
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
