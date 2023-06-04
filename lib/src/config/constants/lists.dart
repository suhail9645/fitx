import 'package:fitx/src/presentation/views/category_screen/category.dart';
import 'package:fitx/src/presentation/views/exercise_screen/exercise.dart';
import 'package:fitx/src/presentation/views/image_screen/image.dart';
import 'package:fitx/src/presentation/views/trainer_screen/trainer.dart';
import 'package:flutter/material.dart';

const List<Widget> pagesList = [
  ImageScreen(),
  CategoryPage(),
  ExercisScreen(),
  TrainerScreen()
];
const List<String> pagesNames = [
  'IMAGES',
  'CATEGORIES',
  'EXERCISES',
  'TRAINER'
];
