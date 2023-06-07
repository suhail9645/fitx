import 'package:fitx/src/config/constants/lists.dart';
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
    // List<String>values=[];
    String groupValue = 'Count';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ExerciceAddBloc, ExerciceAddState>(
                    builder: (context, state) {
                      return Container(
                        height: screenHeight / 3.5,
                        width: screenHeight / 2.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: state is! GifAddState
                                  ? const NetworkImage(imageAddPageImage)
                                  : FileImage(state.gif) as ImageProvider,
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ],
              ),
              spaceforHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimartButtonWithoutIcon(
                    screenHeight: screenHeight,
                    category: ButtonCategory.addExerciceGif,
                  )
                ],
              ),
              spaceforHeight10,
              Column(
                children: List.generate(
                    exerciceAddPageTextEditingControllerHint.length - 1,
                    (index) => CustomTextFormField(
                        controller: exerciceAddPageTextEditingControllers[index],
                        hint: exerciceAddPageTextEditingControllerHint[index],
                        obscureText: false)),
              ),
              Row(
                children: [
                  CustomRadio(
                    groupValue: groupValue,
                    value: 'Time',
                  ),
                  CustomRadio(
                    groupValue: groupValue,
                    value: 'Count',
                  ),
                ],
              ),
              CustomTextFormField(
                  controller: exerciceAddPageTextEditingControllers.last,
                  hint: exerciceAddPageTextEditingControllerHint.last,
                  obscureText: false),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: screenHeight / 14),
                  itemCount: muscleList.length,
                  itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(muscleList[index]),
                        leading: Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                      )),
              spaceforHeight20,
              PrimartButtonWithoutIcon(
                  screenHeight: screenHeight,
                  category: ButtonCategory.saveExercice,formKey: _formKey,),
                   spaceforHeight20,
            ],
          ),
        ),
      )),
    );
  }
}

class CustomRadio extends StatelessWidget {
  const CustomRadio({super.key, required this.groupValue, required this.value});

  final String groupValue;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListTile(
        leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {},
        ),
        title: Text(value),
      ),
    );
  }
}
