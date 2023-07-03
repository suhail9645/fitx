part of 'categoryadd_bloc.dart';

@immutable
abstract class CategoryaddEvent {}

class AddImageCategoryEvent extends CategoryaddEvent {}

class SaveSuccessCategoryEvent extends CategoryaddEvent {}

class CategoryAddPagePopEvent extends  CategoryaddEvent {}

