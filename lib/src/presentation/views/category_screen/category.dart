import 'package:fitx/src/config/constants/colors.dart';
import 'package:fitx/src/presentation/views/image_screen/image_screen.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          spaceforHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimartButtonWithoutIcon(
                  screenHeight: screenHeight,
                  category: ButtonCategory.addCategory)
            ],
          ),
          spaceforHeight20,
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                    10,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight / 4.6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor,),
                                child:const Padding(
                                  padding:  EdgeInsets.only(left: 10),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                   
                                    children: [
                                      spaceforHeight20,
                                      Text('Fast fat Burn',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                      Text('12 Workouts',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                
                                    ],
                                  ),
                                ),
                          ),
                        )),
              ),
            ),
          )
        ],
      )),
    );
  }
}
