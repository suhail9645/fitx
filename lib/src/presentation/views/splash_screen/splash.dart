import 'package:fitx/src/config/constants/strings.dart';
import 'package:fitx/src/config/constants/sized_box.dart';
import 'package:flutter/material.dart';

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
              Container(
                height: screenHeight / 20,
                width: screenHeight / 22,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://w7.pngwing.com/pngs/1020/627/png-transparent-bicep-muscle-emoticon-arm-biceps-emoji-muscle-hand-people-human-body.png'),
                        fit: BoxFit.cover)),
              ),
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
