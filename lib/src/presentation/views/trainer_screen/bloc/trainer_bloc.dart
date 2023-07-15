import 'dart:async';
import 'package:fitx/src/data/repositories/local/trainer/trainer_operation_repo.dart';
import 'package:fitx/src/domain/model/trainer_list/result.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_barell.dart';
part 'trainer_event.dart';
part 'trainer_state.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  TrainerBloc() : super(TrainerInitial()) {
    on<TrainerInitialEvent>(trainerInitialEvent);
    on<TrainerAcceptEvent>(trainerAcceptEvent);
    on<TrainerRejectEvent>(trainerRejectEvent);
  }

  Future<void> trainerInitialEvent(
      TrainerInitialEvent event, Emitter<TrainerState> emit) async {
    emit(TrainerFetchLoadingState());
    final successOrFailure = await TrainerRepo().getAllTrainers();
    if (successOrFailure.isRight) {
      emit(TrainerFetchSuccessState(allApplication: successOrFailure.right));
    } else {
      emit(TrainerFetchErrorState(error: successOrFailure.left.error));
    }
  }

  Future<void> trainerAcceptEvent(
      TrainerAcceptEvent event, Emitter<TrainerState> emit) async {
    final successOrError =
        await TrainerRepo().trainerAcceptAndReject(event.id, 'accept');
    if (successOrError.isRight) {
      emit(TrinerAcceptOrRejectMessageState(message: successOrError.right));
      trainerBloc.add(TrainerInitialEvent());
    } else {
      emit(
          TrinerAcceptOrRejectMessageState(message: successOrError.left.error));
    }
  }

  Future<void> trainerRejectEvent(
      TrainerRejectEvent event, Emitter<TrainerState> emit) async {
    final successOrError =
        await TrainerRepo().trainerAcceptAndReject(event.id, 'reject');
    if (successOrError.isRight) {
      emit(TrinerAcceptOrRejectMessageState(message: successOrError.right));
      trainerBloc.add(TrainerInitialEvent());
    } else {
      emit(
          TrinerAcceptOrRejectMessageState(message: successOrError.left.error));
    }
  }
}
