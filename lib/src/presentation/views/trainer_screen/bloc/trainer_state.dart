part of 'trainer_bloc.dart';

abstract class TrainerState {}

class TrainerInitial extends TrainerState {}

class TrainerFetchSuccessState extends TrainerState {
  final List<Result> allApplication;

  TrainerFetchSuccessState({required this.allApplication});
}

class TrainerFetchErrorState extends TrainerState {
  final String error;

  TrainerFetchErrorState({required this.error});
}

class TrainerFetchLoadingState extends TrainerState {}

class TrinerAcceptOrRejectMessageState extends TrainerState {
  final String message;

  TrinerAcceptOrRejectMessageState({required this.message});
}
