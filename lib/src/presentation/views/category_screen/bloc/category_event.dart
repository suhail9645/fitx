part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryAddEvent extends CategoryEvent {
  final File image;
  final File music;
  final List<TextEditingController> controllers;
  final List<int> exerciseid;

  CategoryAddEvent(
      {required this.image,
      required this.music,
      required this.controllers,
      required this.exerciseid});
}

class CategoryEditEvent extends CategoryEvent {
  final File? image;
  final File? music;
  final List<TextEditingController> controllers;
  final List<int> exerciseid;
  final int id;

  CategoryEditEvent(
      {required this.image,
      required this.music,
      required this.controllers,
      required this.exerciseid,
      required this.id});
}

class CategoryInitialEvent extends CategoryEvent {}

class CategoryDeleteEvent extends CategoryEvent {
  final int id;

  CategoryDeleteEvent({required this.id});
}
