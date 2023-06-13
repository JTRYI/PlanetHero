import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //used to obtain information about the size constraints of its parent widget
      //used to determine the maximum width available for the leaf image

      return Stack(
        //allow for stacking an image on top of another image
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: ClipRect(
              //clip image to adjust height of image better
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.80, //height of leaf image
                child: Image.asset(
                  'images/leaf.png',
                  width: constraints
                      .maxWidth, //setting the width of the leaf image to match the maximum width of the parent container
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            //Stacking Logo image on top of the leaf image
            top: 40, //40 pixels from the top
            left: 0, //centralising
            right: 0, //centralising
            child: Container(
              alignment: Alignment
                  .topCenter, //aligning logo image to the center and top of the container
              child: Image.asset(
                'images/Logo.png',
                width: 150, //width of logo image
              ),
            ),
          ),
          Positioned(
            // Stacking App Name on top of the leaf image
            top: 215, // 215 pixels from the top
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment
                    .topCenter, //aligning app name to the center and top of the container
                child: Text('PlanetHero', //application name
                    style: TextStyle(
                        fontFamily: 'Ravie',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2)) // sapce out letters for app name
                ),
          ),
        ],
      );
    });
  }
}
