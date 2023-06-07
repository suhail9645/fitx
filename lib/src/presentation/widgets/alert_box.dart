import 'package:fitx/src/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../config/constants/sized_box.dart';
import '../../config/enums/enums.dart';

class CustomAlertBox extends StatelessWidget {
  const CustomAlertBox({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 10, 9, 9),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        height: screenHeight / 2.7,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadiusDirectional.only(
                            topStart: Radius.circular(7),
                            topEnd: Radius.circular(7)),
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://manofmany.com/wp-content/uploads/2021/07/No-Equipment-Home-Workout-2.jpg',
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.dstOut),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 8, top: screenHeight / 7),
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fast Fat Burn',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Are you sure to delete this category?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 232, 240, 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceforHeight10,
            PrimartButtonWithoutIcon(
              screenHeight: screenHeight,
              category: ButtonCategory.deletCategory,
            ),
            spaceforHeight10,
            const InkWell(
                child: Text(
              'Cancel',
              style: TextStyle(fontSize: 15),
            ))
          ],
        ),
      ),
    );
  }
}
