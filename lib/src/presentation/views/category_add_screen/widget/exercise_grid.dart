import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../exercise_screen/bloc/exercise_bloc.dart';
import '../cubit/check_box_cubit.dart';

class CategoryAddPageExercises extends StatelessWidget {
  const CategoryAddPageExercises({
    super.key,
    required this.listId,
  });

  final List<int> listId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        if (state is ExerciseInitial) {
          final exerciseState = state;
          checkBoxCubit.listGenerate(state.exercises.length);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.exercises.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                    colors: [Colors.white, Colors.grey]),
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    image:
                        NetworkImage(state.exercises[index].demo),
                    fit: BoxFit.fill),
              ),
              child: BlocBuilder<CheckBoxCubit, CheckBoxState>(
                builder: (context, state) {
                  final checkState = state as CheckBoxInitial;
                  return Align(
                    alignment: Alignment.topRight,
                    child: Checkbox(
                      value: checkState.isCheck[index],
                      onChanged: (value) {
                        checkBoxCubit.onChanged(value!, index);
                        if (value) {
                          listId.add(
                              exerciseState.exercises[index].id!);
                        } else {
                          listId.removeAt(index);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
