part of 'exercice_add_bloc.dart';

@immutable
abstract class ExerciceAddState {}

class ExerciceAddInitial extends ExerciceAddState {}

class GifAddState extends ExerciceAddState {
  final File gif;

  GifAddState({required this.gif});
}
