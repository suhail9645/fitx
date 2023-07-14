part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryAddedSuccessState extends CategoryState {}

class CategoryAddedErrorState extends CategoryState {
  final String error;

  CategoryAddedErrorState({required this.error});
}

class CategorySuccessState extends CategoryState {
  final List<CategoryModel> categories;

  CategorySuccessState({required this.categories});
}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {}

class CategoryDeleteSuccessState extends CategoryState {}

class CategoryUpdateSuccessState extends CategoryState {}
