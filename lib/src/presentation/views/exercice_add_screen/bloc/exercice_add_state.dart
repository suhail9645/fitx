part of 'exercice_add_bloc.dart';

@immutable
abstract class ExerciceAddState {}

class ExerciceAddInitial extends ExerciceAddState {
  final File? gif;
  final String groupValue;
  final String? editImage;
  ExerciceAddInitial(this.editImage,
      {required this.gif, required this.groupValue});
}
