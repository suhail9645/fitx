import 'dart:io';
import 'package:fitx/main.dart';
import 'package:fitx/src/config/constants/colors.dart';
import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/data/repositories/local/convert_exercise.dart';
import 'package:fitx/src/presentation/views/exercise_screen/bloc/exercise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/sized_box.dart';
import '../../../config/constants/strings.dart';
import '../../../config/enums/enums.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/textFormField.dart';
import 'bloc/exercice_add_bloc.dart';

class ExerciceAddPage extends StatelessWidget {
  ExerciceAddPage({super.key});
  final _formKey = GlobalKey<FormState>();
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
                                      ? const NetworkImage(imageAddPageImage)
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
                            value: 'Time',
                            gif: successState.gif,
                          ),
                          CustomRadio(
                              groupValue: successState.groupValue,
                              value: 'Count',
                              gif: successState.gif),
                        ],
                      ),
                      Visibility(
                          visible: gif == null,
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
                 if(state is ExerciseAddSuccessState){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SuccessFully add new Exercise')));
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
                        if (_formKey.currentState!.validate() && gif != null) {
                          final exercise = await ConvertExerciseObject()
                              .converting(exerciceAddPageTextEditingControllers,
                                  gif!, groupValue);
                          exerciceBloc.add(ExerciseAddEvent(
                              exercise: exercise, groupValue: groupValue));
                        }
                      },
                      child: const Text(
                        'Add Exercise',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 36, 34, 34)),
                      ),
                    ),
                  );
                },
              ),

              // PrimartButtonWithoutIcon(
              //   screenHeight: screenHeight,
              //   category: ButtonCategory.saveExercice,
              //   formKey: _formKey,
              // ),
              spaceforHeight20,
            ],
          ),
        ),
      )),
    );
  }
}

class CustomRadio extends StatelessWidget {
  const CustomRadio(
      {super.key, required this.groupValue, required this.value, this.gif});

  final String groupValue;
  final String value;
  final File? gif;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListTile(
        leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (_) {
            exerciceAddBloc
                .add(TimeAndCountChangeEvent(gif, groupValue: value));
          },
        ),
        title: Text(value),
      ),
    );
  }
}
