import 'package:flutter/material.dart';

class ExercisScreen extends StatelessWidget {
  const ExercisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
          child: Center(
        child: Text('ExercisScreen'),
      )),
    );
  }
}
