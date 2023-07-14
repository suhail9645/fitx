part of 'trainer_bloc.dart';

abstract class TrainerEvent {}

class TrainerInitialEvent extends TrainerEvent {}

class TrainerAcceptEvent extends TrainerEvent {}

class TrainerRejectEvent extends TrainerEvent {}
