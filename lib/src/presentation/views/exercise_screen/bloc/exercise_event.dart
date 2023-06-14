part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class ExerciseAddEvent extends ExerciseEvent {
  final Exercise exercise;
  final String groupValue;

  const ExerciseAddEvent({required this.exercise, required this.groupValue});
}

class ExerciseInitialEvent extends ExerciseEvent {}

class ExerciseDeleteEvent extends ExerciseEvent {
  final int id;

 const ExerciseDeleteEvent({required this.id});

}
