part of 'exercice_add_bloc.dart';

@immutable
abstract class ExerciceAddEvent {}

class GifAddEvent extends ExerciceAddEvent {
  final String groupValue;

  GifAddEvent({required this.groupValue});
}

class TimeAndCountChangeEvent extends ExerciceAddEvent {
  final String groupValue;
  final File? gif;

  TimeAndCountChangeEvent(this.gif, {required this.groupValue});
}

class ExerciseAddSuccess extends ExerciceAddEvent {}

class ExerciseEditEvent extends ExerciceAddEvent{
  final String image;
  final String groupValue;

  ExerciseEditEvent({required this.image,required this.groupValue});
}
