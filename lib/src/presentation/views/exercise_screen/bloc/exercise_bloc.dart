import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx/main.dart';
import 'package:fitx/src/data/repositories/remote/exercise/exercise_operation_imp.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/bloc/exercice_add_bloc.dart';

import '../../../../domain/model/exercise/exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial()) {
    on<ExerciseAddEvent>(exerciseAddEvent);
    on<ExerciseInitialEvent>(exerciseInitialEvent);
  }

  FutureOr<void> exerciseAddEvent(ExerciseAddEvent event, Emitter<ExerciseState> emit) async{
    final response=await ExerciseOperationsImp().addExercice(event.exercise, event.groupValue);
    if(response.isRight){
      exerciceAddBloc.add(ExerciseAddSuccess());
      emit(ExerciseAddSuccessState());
    }else{
      if(response.left.error=='session expired'){

      }else{
        
      }
    }
  }

  FutureOr<void> exerciseInitialEvent(ExerciseInitialEvent event, Emitter<ExerciseState> emit) {
    
  }
}
