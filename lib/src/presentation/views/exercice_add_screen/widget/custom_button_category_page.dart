import '../exercise_add_barell.dart';

class AddExerciseButton extends StatelessWidget {
  const AddExerciseButton({
    super.key,
    required this.screenHeight,
    required this.widget,
    required GlobalKey<FormState> formKey,
    required this.gif,
    required this.groupValue,
  }) : _formKey = formKey;

  final double screenHeight;
  final ExerciceAddPage widget;
  final GlobalKey<FormState> _formKey;
  final File? gif;
  final String groupValue;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseBloc, ExerciseState>(
      listener: (context, state) {
        if (state is ExerciseAddSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('SuccessFully add new Exercise')));
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: screenHeight / 3,
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(primaryColor)),
            onPressed: () async {
              if (widget.type == ExercisAddorEdit.addExercice &&
                  _formKey.currentState!.validate() &&
                  gif != null) {
                final exercise = ConvertExerciseObject().converting(
                    exerciceAddPageTextEditingControllers, gif!, groupValue);
                exerciceBloc.add(ExerciseAddEvent(
                    exercise: exercise, groupValue: groupValue));
              } else if (widget.type == ExercisAddorEdit.editExercise &&
                  _formKey.currentState!.validate()) {
                Exercise exercise = ConvertExerciseObject().converting(
                    exerciceAddPageTextEditingControllers, gif, groupValue);
                ExerciseOperationsImp()
                    .updateExercise(exercise, groupValue, widget.exercise!.id!);
              }
            },
            child: Text(
              widget.type == ExercisAddorEdit.addExercice
                  ? 'Add Exercise'
                  : 'Edit Exercise',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 36, 34, 34)),
            ),
          ),
        );
      },
    );
  }
}
