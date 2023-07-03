import 'package:fitx/src/presentation/views/exercice_add_screen/execice_add.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants/colors.dart';
import '../../../../config/enums/enums.dart';
import '../../../../domain/model/exercise/exercise.dart';
import '../../../widgets/alert_box.dart';

enum ContainerButtonType { exerciseDelete, exerciseEdit }

class ContainerButton extends StatelessWidget {
  const ContainerButton(
      {super.key,
      required this.buttonType,
      required this.exercise,
      required this.screenHeight});
  final ContainerButtonType buttonType;
  final Exercise exercise;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    String text = '';
    Color color = primaryColor;
    if (buttonType == ContainerButtonType.exerciseDelete) {
      text = 'Delete';
      color = Colors.red;
    } else if (buttonType == ContainerButtonType.exerciseEdit) {
      text = 'Edit';
      color = Colors.blue;
    }
    return GestureDetector(
      onTap: () {
        if (buttonType == ContainerButtonType.exerciseDelete) {
          // exerciceBloc.add(ExerciseDeleteEvent(id: id));
          showDialog(
            context: context,
            builder: (context) => CustomAlertBox(
              content: 'Execise',
              screenHeight: screenHeight,
              category: ButtonCategory.deleteExercice,
              exercise: exercise,
            ),
          );
        } else if (buttonType == ContainerButtonType.exerciseEdit) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExerciceAddPage(
              type: ExercisAddorEdit.editExercise,
              exercise: exercise,
            ),
          ));
        }
      },
      child: Container(
        height: 20,
        width: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
