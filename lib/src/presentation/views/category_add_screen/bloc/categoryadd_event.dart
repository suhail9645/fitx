part of 'categoryadd_bloc.dart';

@immutable
abstract class CategoryaddEvent {}

class AddImageEvent extends CategoryaddEvent{}

class SaveCategoryEvent extends CategoryaddEvent{}
