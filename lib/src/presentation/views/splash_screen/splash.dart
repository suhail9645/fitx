import 'package:fitx/src/config/constants/strings.dart';
import 'package:fitx/src/config/constants/sized_box.dart';
import 'package:flutter/material.dart';

import '../../widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
      decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(splashScreenImage), fit: BoxFit.cover),
      ),
    ),
    Positioned(
      top: screenHeight/1.2,
      left: screenWidth/6.1,
      child: SizedBox(
            height: screenHeight/14,
            width: screenWidth/1.2,
            // color: Colors.amber,
            child: Row(
              
            children: [
              AppLogo(screenHeight: screenHeight),
              spaceforwidth10,
              const Column(
                children: [
                  Text('ENERGY & PERSISTENCE\nCONQUER ALL THINGS',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
          ),
    ),
          ],
        ));
  }
}

