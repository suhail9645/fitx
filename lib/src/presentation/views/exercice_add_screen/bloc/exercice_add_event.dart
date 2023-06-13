part of 'exercice_add_bloc.dart';

@immutable
abstract class ExerciceAddEvent {}

class GifAddEvent extends ExerciceAddEvent {
  final String groupValue;

  GifAddEvent({required this.groupValue});

}

class TimeAndCountChangeEvent extends ExerciceAddEvent{
 final String groupValue;
 final File? gif;

TimeAndCountChangeEvent(this.gif, {required this.groupValue});
}
class ExerciseAddSuccess extends ExerciceAddEvent{}
