import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/all_users.dart';

class UpdateUserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //declare the form state
    var userForm = GlobalKey<FormState>();

    //declare user provider
    AllUsers allUsers = Provider.of<AllUsers>(context);

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

    // Create a TextEditingController and set the value for username
    TextEditingController usernameController =
        TextEditingController(text: allUsers.loggedInUser!.username);

    // Create a TextEditingController for email and set the initial value
    TextEditingController emailController =
        TextEditingController(text: allUsers.loggedInUser!.email);

    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('${allUsers.loggedInUser?.profilePic}'),
                radius: 40,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ), //space between circle avatar and username textfield
            Form(
              key: userForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ), //Space between username title and text form field
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade100,
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      enabled: false,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: currentBorder,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20, //Space between text form field and email title
                  ),
                  Text(
                    'Email',
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
                      initialValue: allUsers.loggedInUser!.email.toString(),
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
                    height: 35,
                  ), //Space between comment text field and buttons
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
                                'Save Changes',
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
