import 'package:fitx/src/presentation/views/exercise_screen/exercise.dart';

import 'exercise_add_barell.dart';

class ExerciceAddPage extends StatefulWidget {
  const ExerciceAddPage({super.key, required this.type, this.exercise});
  final ExercisAddorEdit type;
  final Exercise? exercise;

  @override
  State<ExerciceAddPage> createState() => _ExerciceAddPageState();
}

class _ExerciceAddPageState extends State<ExerciceAddPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.type == ExercisAddorEdit.editExercise) {
      ExerciseFunction.addingFieldstoControllers(widget.exercise!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File? gif;
    String groupValue = '';
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercice'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<ExerciceAddBloc, ExerciceAddState>(
                builder: (context, state) {
                  final successState = state as ExerciceAddInitial;
                  gif = successState.gif;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: screenHeight / 3.5,
                            width: screenHeight / 2.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: state.gif == null
                                      ? NetworkImage(
                                          state.editImage ?? imageAddPageImage)
                                      : FileImage(successState.gif!)
                                          as ImageProvider,
                                  fit: BoxFit.cover),
                            ),
                          )
                        ],
                      ),
                      spaceforHeight20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PrimartButtonWithoutIcon(
                            screenHeight: screenHeight,
                            category: ButtonCategory.addExerciceGif,
                            groupValue: successState.groupValue,
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              spaceforHeight10,
              Column(
                children: List.generate(
                    exerciceAddPageTextEditingControllerHint.length,
                    (index) => CustomTextFormField(
                        controller:
                            exerciceAddPageTextEditingControllers[index],
                        hint: exerciceAddPageTextEditingControllerHint[index],
                        obscureText: false)),
              ),
              BlocBuilder<ExerciceAddBloc, ExerciceAddState>(
                builder: (context, state) {
                  final successState = state as ExerciceAddInitial;
                  groupValue = state.groupValue;
                  return Column(
                    children: [
                      Row(
                        children: [
                          CustomRadio(
                            groupValue: successState.groupValue,
                            value: 'Duration',
                            gif: successState.gif,
                          ),
                          CustomRadio(
                              groupValue: successState.groupValue,
                              value: 'Count',
                              gif: successState.gif),
                        ],
                      ),
                      Visibility(
                          visible: gif == null && state.editImage == null,
                          child: const Text(
                            'Please add a gif',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  );
                },
              ),
              spaceforHeight20,
              BlocConsumer<ExerciseBloc, ExerciseState>(
                listener: (context, state) {
                  if (state is ExerciseAddSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('SuccessFully add new Exercise')));
                  } else if (state is EditSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('SuccessFully edited new Exercise')));
                        Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: screenHeight / 3,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryColor)),
                      onPressed: () async {
                        if (widget.type == ExercisAddorEdit.addExercice &&
                            _formKey.currentState!.validate() &&
                            gif != null) {
                          final exercise = ConvertExerciseObject().converting(
                              exerciceAddPageTextEditingControllers,
                              gif!,
                              groupValue);
                          exerciceBloc.add(ExerciseAddEvent(
                              exercise: exercise, groupValue: groupValue));
                        } else if (widget.type ==
                                ExercisAddorEdit.editExercise &&
                            _formKey.currentState!.validate()) {
                          Exercise exercise = ConvertExerciseObject()
                              .converting(exerciceAddPageTextEditingControllers,
                                  gif, groupValue);
                          //  ExerciseOperationsImp().updateExercise(exercise, groupValue, widget.exercise!.id!);
                          exerciceBloc.add(ExerciseEditEventMain(
                              id: widget.exercise!.id!,
                              groupValue: groupValue,
                              exercise: exercise));
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
              ),
              spaceforHeight20,
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    exerciceAddBloc.add(ExerciseAddSuccess());
    super.dispose();
  }
}
