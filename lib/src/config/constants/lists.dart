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

final TextEditingController categoryName = TextEditingController();
final TextEditingController description = TextEditingController();
final TextEditingController music = TextEditingController();
final TextEditingController exerciceName = TextEditingController();
final TextEditingController videoLink = TextEditingController();
final TextEditingController timeOrCount = TextEditingController();
final TextEditingController burnCalory = TextEditingController();
final TextEditingController exerciceDescription = TextEditingController();

final List<TextEditingController> categoryAddPageTextEditingControllers = [
  categoryName,
  description,
  music
];

const List<String> categoryAddPageTextEditingControllerHint = [
  'Category name',
  'Description',
  'music Url'
];
final List<TextEditingController> exerciceAddPageTextEditingControllers = [
  exerciceName,
  exerciceDescription,
  videoLink,
  burnCalory,
  timeOrCount,
];

final List<String> exerciceAddPageTextEditingControllerHint = [
  'Execice name',
  'Description',
  'video Link',
  'burn Calory',
  'time or second',
];
List<String> muscleList = [
  'Biceps',
  'Triceps',
  'Deltoids',
  'Pectoralis',
  'Latissimus Dorsi',
  'Rectus Abdominis',
  'Obliques',
  'Quadriceps',
  'Hamstrings',
  'Gastrocnemius',
  'Trapezius',
  'Serratus Anterior',
  'Gluteus Maximus',
  'Adductor Magnus',
  'Soleus',
  'Tibialis Anterior',
];

List<String> trainerDetailes = [
  'Name',
  'Age',
  'Gender',
  'Experience',
  'Cirtificates'
];
