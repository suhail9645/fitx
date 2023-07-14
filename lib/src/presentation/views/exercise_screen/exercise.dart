import 'package:fitx/main.dart';
import 'package:fitx/src/config/constants/colors.dart';
import 'package:fitx/src/config/enums/enums.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/execice_add.dart';
import 'package:fitx/src/presentation/views/exercise_screen/bloc/exercise_bloc.dart';
import 'package:fitx/src/presentation/views/exercise_screen/widget/alert_box.dart';
import 'package:fitx/src/presentation/widgets/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisScreen extends StatelessWidget {
  const ExercisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    exerciceBloc.add(ExerciseInitialEvent());
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<ExerciseBloc, ExerciseState>(
        listener: (context, state) {
          if (state is DeleteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exercise Deleted')));
          }
        },
        builder: (context, state) {
          if (state is ExerciseInitial) {
            return ListView.builder(
              itemCount: state.exercises.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: const Color.fromARGB(255, 62, 58, 60),
                  leading: Container(
                    width: screenHeight / 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(state.exercises[index].demo),
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: Text(state.exercises[index].name,
                      style: const TextStyle(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold)),
                  subtitle: const Text(
                    'Created on 01/9/2030',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContainerButton(
                          buttonType: ContainerButtonType.exerciseDelete,
                          exercise: state.exercises[index],
                          screenHeight: screenHeight,
                        ),
                        ContainerButton(
                          buttonType: ContainerButtonType.exerciseEdit,
                          exercise: state.exercises[index],
                          screenHeight: screenHeight,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ExercisePageLoadingState) {
            return const Center(
              child: Text('Please wait'),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Something went wrong please try again'),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Try Again')),
                ],
              ),
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ExerciceAddPage(
              type: ExercisAddorEdit.addExercice,
            ),
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
