import 'package:fitx/main.dart';
import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/bloc/exercice_add_bloc.dart';

import '../../../domain/model/exercise/exercise.dart';

class ExerciseFunction {
  static void addingFieldstoControllers(Exercise exercise) {
    exerciceAddPageTextEditingControllers[0].text = exercise.name;
    exerciceAddPageTextEditingControllers[1].text = exercise.description;
    exerciceAddPageTextEditingControllers[2].text = exercise.videoLink;
    exerciceAddPageTextEditingControllers[3].text =
        exercise.burnCalorie.toString();
    exerciceAddPageTextEditingControllers[4].text = exercise.focusedArea;
    exerciceAddPageTextEditingControllers[5].text =
        exercise.count != null ? exercise.count.toString() : exercise.duration;
    exerciceAddBloc.add(ExerciseEditEvent(
        image: exercise.demo,
        groupValue: exercise.count != null ? 'Count' : 'Time'));
  }
}
