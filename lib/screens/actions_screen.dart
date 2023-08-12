import 'package:flutter/material.dart';
import 'package:planethero_application/models/hero-action.dart';
import 'package:planethero_application/screens/login_signup_screen.dart';
import 'clicked_action_screen.dart';
import 'comments_screen.dart';

Color background =
    Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class ActionScreen extends StatefulWidget {
  //declare route name
  static String routeName = '/actions';

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  //Populate a list of actions
  static List<HeroAction> allActions = [
    HeroAction(
        'https://s.wsj.net/public/resources/images/WK-AN111_BAGS_j_O_20080924123035.jpg',
        'Bring Recycle Bags',
        5,
        'Easy',
        '''Instead of buying or taking a single-use plastic bag when you go shopping, simply bring your own recycle bags!

Plastic bags are used for an average of 12 minutes before ending 
up in the thrash and then it takes hundreds of years to degrade 
in a landfill.

Oil, which is a fossil fuel and a non-renewable resource, 
is used to make plastic bags. Because the production of 
disposable plastic shopping bags also releases greenhouse 
gases into the atmosphere, reducing demand will result in 
less production, which will free up more nonrenewable 
resources for use in other ways and reduce the amount of 
greenhouse gases released into the atmosphere.'''),
    HeroAction(
        'https://images.ctfassets.net/z3ixs6i8tjtq/1RK1N83Bd246C6q68gicUO/f970cf756bb0a3786a87b922f368762f/clothes-line-615962_640.jpg?q=90&fl=progressive&w=961&fit=fill',
        'Air-Dry Clothes After Washing',
        10,
        'Medium',
        '''First and foremost, line drying your clothes will save on energy! You probably already use the best detergent to wash your clothes, and as such you want your drying process to be equally eco-friendly. For many households, the clothes dryer is the second-most energy-consuming appliance, right after the refrigerator. However, by simply switching from using a clothes dryer to air-drying your clothes after washing them, you could reduce your home’s carbon footprint 2,400 pounds a year. '''),
    HeroAction(
        'https://images.pexels.com/photos/5970279/pexels-photo-5970279.jpeg?cs=srgb&dl=pexels-alexandre-saraiva-carniato-5970279.jpg&fm=jpg',
        'Cycle Instead of Taking Cars',
        100,
        'Hard',
        '''The longer you use your bike, the better for the planet. Riding a bike also reduces traffic congestion. Idling cars are bad for the environment, so less cars on the road means a healthier community. Someone riding a bike can go 960 miles on the amount of energy that goes into moving a car 20 miles.''')
  ];

  //creating the list that we're going to display and filter
  List<HeroAction> displayList = List.from(allActions);

  void updateList(String value) {
    setState(() {
      displayList = allActions
          .where((action) =>
              action.actionTitle.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void sortActionsByPointsHighToLow() {
    displayList.sort((a, b) => b.heroPoints.compareTo(a.heroPoints));
  }

  void sortActionsByPointsLowToHigh() {
    displayList.sort((a, b) => a.heroPoints.compareTo(b.heroPoints));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 35, left: 35, right: 35, bottom: 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //crossaxisalignment.start allows whatever items in
            //the column to start from the starting point of the search bar
            children: [
              Container(
                width: MediaQuery.of(context).size.width -
                    70, //Gets size of screen and minus 70
                height: 35,
                child: TextField(
                  onChanged: (value) => updateList(value),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10), //equal vertical padding of 10px
                      hintText: 'Search Actions',
                      hintStyle: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 20,
                        ),
                        onPressed: () {},
                      )),
                ),
              ), //Search Bar Widget
              SizedBox(
                height: 20, //Space between search bar and "Actions" Title
              ),
              Text(
                'Actions',
                style: TextStyle(fontFamily: 'Roboto Bold', fontSize: 20),
              ),
              SizedBox(
                height: 5, //Space between "Actions" Title and subtext
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Steps you can take to build a Sustainable',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            //show bottom sheet dialogue on tap
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                height: 100,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sortActionsByPointsLowToHigh();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Text(
                                        'Low - High Hero Points',
                                        style: TextStyle(
                                            fontFamily: 'Roboto Bold',
                                            fontSize: 15),
                                      ),
                                    ),
                                    Divider(
                                      height: 20,
                                      color: Colors.grey.shade300,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sortActionsByPointsHighToLow();
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Text(
                                        'High - Low Hero Points',
                                        style: TextStyle(
                                            fontFamily: 'Roboto Bold',
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.filter_alt_sharp,
                          color: Colors.greenAccent.shade400,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Future!',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.all(
                    0), // Set padding to zero, default padding leaves alot of space before starting the first row
                itemBuilder: (ctx, i) {
                  HeroAction currentAction = displayList[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ClickedAction.routeName,
                          arguments: currentAction);
                    },
                    child: Column(
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
                                color: Colors.black.withOpacity(
                                    0.1), //Shadow color with opacity
                                blurRadius: 20, //Amount of blur for the shadow
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15), // Rounded corners for the image
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
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 10),
                              ),
                            ),
                            Spacer(), //give space between 'Hero Points' and 'Difficulty'
                            Text(
                              'Difficulty',
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 10),
                            ),
                            Spacer(), //give space between 'Difficulty' and 'Comments'
                            Padding(
                              padding: const EdgeInsets.only(
                                  right:
                                      50), //Move 'Comments' 50px from the right of column
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 10),
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
                                  left: currentAction.heroPoints
                                              .toString()
                                              .length ==
                                          1
                                      ? 38 //If hero points is 1 digit, return padding of 44px from the left
                                      : (currentAction.heroPoints
                                                  .toString()
                                                  .length ==
                                              2
                                          ? 29 //else if hero points is 2 digit, return padding of 34px from the left
                                          : 21)), //else if neither 1 or 2 digit, return padding of 23px from the left
                              child: Text(
                                '${currentAction.difficulty}',
                                style: TextStyle(
                                    fontFamily: 'Roboto Bold',
                                    fontSize: 10,
                                    color: getColorForDifficulty(
                                        currentAction.difficulty)),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      CommentsScreen.routeName,
                                      arguments: currentAction);
                                },
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
                    ),
                  );
                },
                separatorBuilder: (ctx, i) {
                  return const Divider(
                    height: 20, //20px of space between the actions
                    color: Colors.transparent, //make it invisible
                  );
                },
                itemCount: displayList.length,
              ))
            ]),
      ),
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
