// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:planethero_application/widgets/logo-image.dart';
import 'package:provider/provider.dart';

import '../providers/all_users.dart';

//background colour
String hexColor = "#f2f4f3";
Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class LoginSignupScreen extends StatefulWidget {
  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  bool isRememberMe = false;

  //Texts for sign up form
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Texts for Login Form
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  //form key for Sign up form
  var formKey = GlobalKey<FormState>();

  //form key for login form
  var formLoginKey = GlobalKey<FormState>();

  //function to save sign up form
  void saveForm(usersList) {
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    int actionsCompleted = 0;
    int heroPoints = 0;

    bool isValid = formKey.currentState!.validate();

    if (isValid) {
      debugPrint(email);
      debugPrint(username);
      debugPrint(password);

      usersList.registerUser(
          username, email, password, actionsCompleted, heroPoints);

      usersList.printUsers();
      //reset the form
      formKey.currentState!.reset();
      //show a snackbar of user registered successfully
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registered successfully!'),
      ));
    }
  }

  void saveLoginForm(usersList) {
    String loginEmail = emailLoginController.text;
    String loginPassword = passwordLoginController.text;

    bool isLoginValid = formLoginKey.currentState!.validate();

    if (isLoginValid) {
      debugPrint(loginEmail);
      debugPrint(loginPassword);

      usersList.loginUser(loginEmail, loginPassword);

      formLoginKey.currentState!.reset();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //declare the user provider
    AllUsers usersList = Provider.of<AllUsers>(context);

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned(top: 0, right: 0, left: 0, child: LogoImage()),
          //Submit button
          buildBottomHalfContainer(usersList, true),
          //Main Container for Login and Signup
          // Use Animated Positioned to show animation when switching between login and sign up form
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.bounceOut,
            top: 300,
            // Use a Animated Container to show some animation when switching between login and sign up form
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              curve: Curves.bounceOut,
              height: isSignupScreen ? 300 : 260,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Login
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (!isSignupScreen) // if its not sign up screen
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: !isSignupScreen
                                      ? Colors.greenAccent.shade700
                                      : Colors.white,
                                )
                            ],
                          ),
                        ),
                        // Sign Up
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isSignupScreen) //if it is sign up screen
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: isSignupScreen
                                      ? Colors.greenAccent.shade700
                                      : Colors.white,
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSignupScreen)
                      // Text Fields
                      buildSignupSection(),
                    if (!isSignupScreen) buildLoginSection()
                  ],
                ),
              ),
            ),
          ),
          //Submit button
          buildBottomHalfContainer(usersList, false),
          // Or Sign Up With Section
          Positioned(
              top: MediaQuery.of(context).size.height - 70,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    isSignupScreen ? 'Or Sign Up With' : "Or Login With",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial',
                        color: Colors.grey.shade500),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 25, left: 25, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildTextButton(MdiIcons.facebook, "Facebook",
                            Colors.blue.shade900),
                        buildTextButton(
                            MdiIcons.googlePlus, "Google", Colors.red.shade700),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

//Login Form
  Container buildLoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: formLoginKey,
        child: Column(
          children: [
            buildLoginTextField(MdiIcons.emailOutline, "Email", false, true,
                (value) {
              if (value == null || value.length == 0) {
                return 'Please enter an email!';
              } else {
                return null;
              }
            }, emailLoginController),
            buildLoginTextField(MdiIcons.lockOutline, "Password", true, false,
                (value) {
              if (value == null || value.length == 0) {
                return 'Please enter a password!';
              } else {
                return null;
              }
            }, passwordLoginController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: isRememberMe,
                        onChanged: (value) {
                          setState(() {
                            isRememberMe = !isRememberMe;
                          });
                        }),
                    Text(
                      "Remember Me",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontFamily: 'Arial'),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontFamily: 'Arial'),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

// Sign Up Form
  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            buildTextField(
                MdiIcons.accountCowboyHatOutline, "Username", false, false,
                (value) {
              if (value == null || value.length == 0) {
                return 'Please enter a username!';
              } else if (value.length < 3) {
                return 'Please enter a username longer than 3 letters! ';
              } else {
                return null;
              }
            }, usernameController),
            buildTextField(MdiIcons.emailOutline, "Email", false, true,
                (value) {
              if (value == null || value.length == 0) {
                return 'Please enter an email!';
              } else {
                return null;
              }
            }, emailController),
            buildTextField(MdiIcons.lockOutline, "Password", true, false,
                (value) {
              if (value == null || value.length == 0) {
                return 'Please enter a password!';
              } else {
                return null;
              }
            }, passwordController),
          ],
        ),
      ),
    );
  }

//Facebook and Google button method, its like a object, change the parameters to show what u want.
  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            side: BorderSide(width: 1, color: Colors.grey),
            minimumSize: Size(145, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            backgroundColor: backgroundColor),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(fontFamily: 'Arial', fontSize: 13),
            ),
          ],
        ));
  }

//Submit button method, like a object
  Widget buildBottomHalfContainer(usersList, bool showShadow) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 600),
        curve: Curves.bounceOut,
        top: isSignupScreen ? 555 : 515,
        right: 0,
        left: 0,
        child: Center(
          child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                ]),
            child: !showShadow
                ? Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent.shade700,
                              Colors.greenAccent.shade400
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        isSignupScreen
                            ? saveForm(usersList)
                            : saveLoginForm(usersList);
                      },
                      child: Icon(
                        MdiIcons.arrowRight,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Center(),
          ),
        ));
  }

//Sign up Text Fields method, like a object. Text fields for sign up
  Widget buildTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      String? Function(String?)? validator,
      TextEditingController controller) {
    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade400),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade400),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder currentBorder = enabledBorder;
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 10.0), // give 8px of spacing between each text fields
      child: TextFormField(
        controller: controller, // Set the controller for the text field
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: currentBorder,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          contentPadding: EdgeInsets.all(5),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'Arial',
            color: Colors.grey.shade500,
          ),
        ),
        validator:
            validator as String? Function(String?)?, // Set validator callback
      ),
    );
  }

//Login Text Fields method, like a object. Text fields for Login
  Widget buildLoginTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      String? Function(String?)? validator,
      TextEditingController controller) {
    OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade400),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent.shade400),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );

    OutlineInputBorder currentBorder = enabledBorder;
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 10.0), // give 8px of spacing between each text fields
      child: TextFormField(
        controller: controller, // Set the controller for the text field
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: currentBorder,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          contentPadding: EdgeInsets.all(5),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'Arial',
            color: Colors.grey.shade500,
          ),
        ),
        validator:
            validator as String? Function(String?)?, // Set validator callback
      ),
    );
  }
}
