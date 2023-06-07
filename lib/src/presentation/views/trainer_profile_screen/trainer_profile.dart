import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/config/enums/enums.dart';
import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import 'package:fitx/src/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: screenHeight / 12,
                  child: CircleAvatar(
                    radius: screenHeight / 14,
                    backgroundImage: const NetworkImage(
                        'https://wisehealthynwealthy.com/wp-content/uploads/2022/01/CreativecaptionsforFacebookprofilepictures.jpg'),
                  ),
                )
              ],
            ),
            Column(
                children: List.generate(
              trainerDetailes.length - 1,
              (index) => Padding(
                padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
                child: Container(
                  height: screenHeight / 13,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 222, 65, 211),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${trainerDetailes[index]}:',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 62, 49, 49),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text('Trainer $index',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17))
                    ],
                  ),
                ),
              ),
            )),
            const Text('Cirtificates'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) => Padding(
                          padding: const EdgeInsets.only(top: 8, left: 6),
                          child: Container(
                            height: screenHeight / 8,
                            width: screenHeight / 10,
                            color: Colors.white,
                            child: const Align(
                              child: Text(
                                'Pdf',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            spaceforHeight20,
            PrimartButtonWithoutIcon(screenHeight: screenHeight, category:ButtonCategory.hireTrainer )
          ],
        ),
      ),
    );
  }
}
