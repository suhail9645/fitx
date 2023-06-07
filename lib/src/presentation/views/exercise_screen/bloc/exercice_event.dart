part of 'exercice_bloc.dart';

@immutable
abstract class ExerciceEvent {}




class ExerciceEditEvent extends ExerciceEvent {}

class ExerciceNewAddEvent extends ExerciceEvent {}
