import 'package:flutter/material.dart';

import '../widgets/bottom-navbar.dart';

class ActionScreen extends StatelessWidget {
  //declare route name
  static String routeName = '/actions';

  @override
  Widget build(BuildContext context) {
    final int initialIndex =
        ModalRoute.of(context)?.settings.arguments as int? ?? 0;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        initialIndex: initialIndex,
      ),
    );
  }
}
