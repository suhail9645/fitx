import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx/src/data/repositories/local/trainer/trainer_operation_repo.dart';
import 'package:fitx/src/domain/model/trainer_list/result.dart';

part 'trainer_event.dart';
part 'trainer_state.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  TrainerBloc() : super(TrainerInitial()) {
    on<TrainerInitialEvent>(trainerInitialEvent);
  }

  Future<void> trainerInitialEvent(TrainerInitialEvent event, Emitter<TrainerState> emit)async {
    emit(TrainerFetchLoadingState());
    final successOrFailure=await TrainerRepo().getAllTrainers();
    if(successOrFailure.isRight){
      emit(TrainerFetchSuccessState(allApplication: successOrFailure.right));
    }else{
      emit(TrainerFetchErrorState(error: successOrFailure.left.error));
    }
  }
}
