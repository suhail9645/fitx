import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fitx/main.dart';
import 'package:fitx/src/data/repositories/remote/category_operation_imp.dart';
import 'package:fitx/src/presentation/views/category_add_screen/bloc/categoryadd_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/model/category/category.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryAddEvent>(categoryAddEvent);
    on<CategoryInitialEvent>(categoryInitialEvent);
    on<CategoryDeleteEvent>(categoryDeleteEvent);
    on<CategoryEditEvent>(categoryEditEvent);
  }

  FutureOr<void> categoryAddEvent(
      CategoryAddEvent event, Emitter<CategoryState> emit) async {
    final response = await CategoryOperationImp().categoryAdd(
        event.controllers, event.image, event.music, event.exerciseid);
    if (response.isRight) {
      checkBoxCubit.onSavedCategory();
      categoryaddBloc.add(SaveSuccessCategoryEvent());

      emit(CategoryAddedSuccessState());
    } else {
      emit(CategoryAddedErrorState(error: response.left.error));
    }
  }

  FutureOr<void> categoryInitialEvent(
      CategoryInitialEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final response = await CategoryOperationImp().getAllCategories();
    if (response.isRight) {
      emit(CategorySuccessState(categories: response.right));
    } else {
      emit(CategoryErrorState());
    }
  }

  FutureOr<void> categoryDeleteEvent(
      CategoryDeleteEvent event, Emitter<CategoryState> emit) async {
    final response = await CategoryOperationImp().deleteCategory(event.id);
    if (response.isRight) {
      emit(CategoryDeleteSuccessState());
      categoryBloc.add(CategoryInitialEvent());
    } else {
      emit(CategoryErrorState());
    }
  }

  FutureOr<void> categoryEditEvent(
      CategoryEditEvent event, Emitter<CategoryState> emit) async {
    final response = await CategoryOperationImp().updateCategory(
        event.controllers,
        event.id,
        event.image,
        event.music,
        event.exerciseid);
    if (response.isRight) {
      emit(CategoryUpdateSuccessState());
      categoryBloc.add(CategoryInitialEvent());
    } else {
      emit(CategoryErrorState());
    }
  }
}
