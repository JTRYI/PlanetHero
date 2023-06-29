import 'package:flutter/material.dart';
import 'package:planethero_application/models/hero-action.dart';

class AllActions with ChangeNotifier {
  //Populate a list of actions
  List<HeroAction> allActions = [
    HeroAction(
        'https://s.wsj.net/public/resources/images/WK-AN111_BAGS_j_O_20080924123035.jpg',
        'Bring Recycle Bags',
        5,
        'Easy',
        '''Instead of buying or taking a single-use plastic bag when you go shopping, simply bring your own recycle bags!

      Plastic bags are used for an average of 12 minutes
      before ending up in the thrash and then it takes
      hundreds of years to degrade in a landfill.

      Oil, which is a fossil fuel and a non-renewable
      resource, is used to make plastic bags. Because the
      production of disposable plastic shopping bags also
      releases greenhouse gases into the atmosphere,
      reducing demand will result in less production, which
      will free up more nonrenewable resources for use in
      other ways and reduce the amount of greenhouse
      gases released into the atmosphere.'''),
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

  //function to get all actions
  List<HeroAction> getActions() {
    return allActions;
  }
}
