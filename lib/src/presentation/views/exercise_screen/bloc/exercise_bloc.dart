import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx/main.dart';
import 'package:fitx/src/data/repositories/remote/exercise_operation_imp.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/bloc/exercice_add_bloc.dart';

import '../../../../domain/model/exercise/exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial(exercises: [])) {
    on<ExerciseAddEvent>(exerciseAddEvent);
    on<ExerciseInitialEvent>(exerciseInitialEvent);
    on<ExerciseDeleteEvent>(exerciseDeleteEvent);
    on<ExerciseEditEventMain>(exerciseEditEventMain);
  }

  FutureOr<void> exerciseAddEvent(
      ExerciseAddEvent event, Emitter<ExerciseState> emit) async {
    final response = await ExerciseOperationsImp()
        .addExercice(event.exercise, event.groupValue);
    if (response.isRight) {
      exerciceAddBloc.add(ExerciseAddSuccess());
      exerciceBloc.add(ExerciseInitialEvent());
      emit(ExerciseAddSuccessState());
    } else {
      if (response.left.error == 'session expired') {
      } else {}
    }
  }

  FutureOr<void> exerciseInitialEvent(
      ExerciseInitialEvent event, Emitter<ExerciseState> emit) async {
    emit(ExercisePageLoadingState());
    final response = await ExerciseOperationsImp().getAllExercises();
    if (response.isRight) {
      emit(ExerciseInitial(exercises: response.right));
    } else {
      emit(ExercisePageErrorState());
    }
  }

  FutureOr<void> exerciseDeleteEvent(
      ExerciseDeleteEvent event, Emitter<ExerciseState> emit) async {
    final response = await ExerciseOperationsImp().deleteExercise(event.id);
    if (response.isRight) {
      emit(DeleteSuccessState());
      exerciceBloc.add(ExerciseInitialEvent());
    }
  }

  FutureOr<void> exerciseEditEventMain(
      ExerciseEditEventMain event, Emitter<ExerciseState> emit) async {
    final response = await ExerciseOperationsImp()
        .updateExercise(event.exercise, event.groupValue, event.id);
    if (response.isRight) {
      emit(EditSuccessState());
    }
  }
}
