part of 'trainer_bloc.dart';

abstract class TrainerEvent {}

class TrainerInitialEvent extends TrainerEvent {}

class TrainerAcceptEvent extends TrainerEvent {
  final int id;

  TrainerAcceptEvent({required this.id});
}

class TrainerRejectEvent extends TrainerEvent {
  final int id;

  TrainerRejectEvent({required this.id});
}
