part of 'categoryadd_bloc.dart';

@immutable
abstract class CategoryaddState {}

class CategoryaddInitial extends CategoryaddState {}

class AddImageState extends CategoryaddState {
  final File image;

  AddImageState({required this.image});
}

class SaveCategoryState extends CategoryaddState {}


