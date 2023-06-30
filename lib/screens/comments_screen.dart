import 'package:flutter/material.dart';
import 'package:planethero_application/widgets/add-comment-modal.dart';
import 'package:planethero_application/widgets/listview-comments.dart';
import '../models/hero-action.dart';
import 'login_signup_screen.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class CommentsScreen extends StatefulWidget {
  //declare route name
  static String routeName = '/comments-screen';

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    // retrieve the arguments
    HeroAction selectedAction =
        ModalRoute.of(context)?.settings.arguments as HeroAction;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          '${selectedAction.actionTitle} Comments',
          style: TextStyle(fontFamily: 'Roboto Bold'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: ListComments(selectedAction),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddCommentModal(selectedAction),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
