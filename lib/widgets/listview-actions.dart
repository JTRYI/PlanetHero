import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/providers/all_actions.dart';
import 'package:provider/provider.dart';

class ListActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //declare Actions provider
    AllActions allActions = Provider.of<AllActions>(context);

    return ListView.separated(
      itemBuilder: (ctx, i) {
        HeroAction currentAction = allActions.getActions()[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 70,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    15), // Rounded corners for the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), //Shadow color with opacity
                    blurRadius: 20, //Amount of blur for the shadow
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Rounded corners for the image
                child: Image.network(
                  currentAction.imageUrl,
                  fit: BoxFit
                      .cover, // Scale the image to cover the entire container),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ), //Space between image and title
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '${currentAction.actionTitle}',
                style: TextStyle(
                  fontFamily: 'Roboto Bold',
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ), //Space between title and next row
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left:
                          12), //Give 12px of spacing from the left, aligning text under the title
                  child: Text(
                    'Hero Points',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                  ),
                ),
                Spacer(), //give space between 'Hero Points' and 'Difficulty'
                Text(
                  'Difficulty',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                ),
                Spacer(), //give space between 'Difficulty' and 'Comments'
                Padding(
                  padding: const EdgeInsets.only(
                      right:
                          50), //Move 'Comments' 50px from the right of column
                  child: Text(
                    'Comments',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ), //Give 12px of spacing from the left, aligning text under 'Hero Points'
                  child: Text(
                    '${currentAction.heroPoints}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.greenAccent.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                      left: currentAction.heroPoints.toString().length == 1
                          ? 44 //If hero points is 1 digit, return padding of 44px from the left
                          : (currentAction.heroPoints.toString().length == 2
                              ? 34 //else if hero points is 2 digit, return padding of 34px from the left
                              : 23)), //else if neither 1 or 2 digit, return padding of 23px from the left
                  child: Text(
                    '${currentAction.difficulty}',
                    style: TextStyle(
                        fontFamily: 'Roboto Bold',
                        fontSize: 10,
                        color: getColorForDifficulty(currentAction.difficulty)),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.comment_rounded,
                      size: 15,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
      separatorBuilder: (ctx, i) {
        return const Divider(
          height: 20, //20px of space between the actions
          color: Colors.transparent, //make it invisible
        );
      },
      itemCount: allActions.getActions().length,
    );
  }
}

//function to show what color base on the difficulty of action
getColorForDifficulty(String difficulty) {
  if (difficulty == 'Easy') {
    return Colors.greenAccent.shade400;
  } else if (difficulty == 'Medium') {
    return Colors.orange.shade400;
  } else if (difficulty == 'Hard') {
    return Colors.red;
  }
}
