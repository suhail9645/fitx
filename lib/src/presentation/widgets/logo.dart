import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 20,
      width: screenHeight / 22,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://w7.pngwing.com/pngs/1020/627/png-transparent-bicep-muscle-emoticon-arm-biceps-emoji-muscle-hand-people-human-body.png'),
              fit: BoxFit.cover)),
    );
  }
}
