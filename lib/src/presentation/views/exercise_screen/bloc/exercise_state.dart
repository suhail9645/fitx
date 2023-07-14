part of 'exercise_bloc.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {
  final List<Exercise> exercises;

  ExerciseInitial({required this.exercises});
}

class ExercisePageLoadingState extends ExerciseState {}

class ExercisePageErrorState extends ExerciseState {}

class ExerciseAddLoading extends ExerciseState {}

class ExerciseAddSuccessState extends ExerciseState {}

class DeleteSuccessState extends ExerciseState {}

class EditSuccessState extends ExerciseState {}
