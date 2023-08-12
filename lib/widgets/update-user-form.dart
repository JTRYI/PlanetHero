import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:planethero_application/models/user.dart';
import 'package:planethero_application/services/user_service.dart';

import '../global/current_user_singleton.dart';

class UpdateUserForm extends StatefulWidget {
  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  File? profilePicture;

  // Access the currentUser from the singleton
  final currentUser = CurrentUserSingleton().currentUser;

  Future<void> pickImage(mode) {
    ImageSource chosenSource =
        mode == 0 ? ImageSource.camera : ImageSource.gallery;
    return ImagePicker()
        .pickImage(
            source: chosenSource,
            maxWidth: 600,
            imageQuality: 50,
            maxHeight: 150)
        .then((imageFile) {
      if (imageFile != null) {
        setState(() {
          profilePicture = File(imageFile.path);
        });
      }
    });
  }

  updateProfile(context) async {
    if (profilePicture == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please include a profile image!'),
      ));
      return;
    }
    String? base64;
    Reference ref = FirebaseStorage.instance.ref().child(
        DateTime.now().toString() + '_' + basename(profilePicture!.path));
    UploadTask uploadTask = ref.putFile(profilePicture!);

    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    
      base64 = imageUrl.toString();
      // Call the method from the singleton to update the profile picture URL
      CurrentUserSingleton().updateProfilePictureUrl(base64);
    

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update({
      'profilePic': base64,
    });
  }

  @override
  Widget build(BuildContext context) {
    //declare the form state
    var userForm = GlobalKey<FormState>();

    //declare updated username
    String? updatedUsername;

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

    void updateUsername(uid) {
      bool isValid = userForm.currentState!.validate();

      if (isValid) {
        userForm.currentState!.save();

        //decalre user service
        UserService userService = UserService();
        userService.updateUsername(uid, updatedUsername);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Username updated successfully!'),
        ));

        //widget will rebuild and reflect the updated username in the TextFormField.
        setState(() {
          currentUser.username = updatedUsername!;
        });
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profilePicture == null
                              ? NetworkImage(currentUser.profilePic)
                              : FileImage(profilePicture!) as ImageProvider)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    TextButton.icon(
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 15,
                        ),
                        onPressed: () => pickImage(0),
                        label: const Text(
                          'Take Photo',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold', fontSize: 10),
                        )),
                    TextButton.icon(
                        icon: const Icon(Icons.image, size: 15),
                        onPressed: () => pickImage(1),
                        label: const Text(
                          'Add Image',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold', fontSize: 10),
                        )),
                  ],
                ),
                Spacer(),
                Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade700.withOpacity(
                          0.5), //setting background colour with reduced opacity
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.greenAccent.shade700),
                    ),
                    child: TextButton(
                        onPressed: () {
                          updateProfile(context);
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontFamily: 'Roboto Bold',
                              color: Colors.white,
                              fontSize: 12),
                        ))),
              ],
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
                    'Email',
                    style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ), //Space between username title and text form field
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade100),
                    child: TextFormField(
                      initialValue: currentUser.email,
                      enabled: false,
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
                    height: 20, //Space between text form field and email title
                  ),
                  Text(
                    'Username',
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
                      initialValue: currentUser.username,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12),
                      decoration: InputDecoration(
                        border: enabledBorder,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a username.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        updatedUsername = value as String;
                      },
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
                              onPressed: () {
                                updateUsername(currentUser.uid);
                              },
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
