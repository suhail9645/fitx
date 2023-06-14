import 'dart:io';
import 'package:fitx/main.dart';
import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/config/constants/sized_box.dart';
import 'package:fitx/src/data/repositories/local/mp3_picker.dart';
import 'package:fitx/src/domain/model/category/category.dart';
import 'package:fitx/src/presentation/views/category_add_screen/widget/exercise_grid.dart';
import 'package:fitx/src/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/strings.dart';
import '../../../config/enums/enums.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/textFormField.dart';
import '../category_screen/bloc/category_bloc.dart';
import 'bloc/categoryadd_bloc.dart';
enum CategoryAddOrEdit{
  categoryAdd,categoryEdit
}
// ignore: must_be_immutable
class CategoryAddPage extends StatefulWidget {
 const CategoryAddPage({super.key, required this.type, this.category});
  final CategoryAddOrEdit type;
  final CategoryModel? category;
  
  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {

  @override
  void initState() {
    if(widget.type==CategoryAddOrEdit.categoryEdit){
      categoryAddPageTextEditingControllers[0].text=widget.category!.name!;
      categoryAddPageTextEditingControllers[1].text=widget.category!.description!;
       categoryAddPageTextEditingControllers[2].text=widget.category!.music!.split('/').last;
      
    }
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  File? music;

  File? image;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    List<int> listId = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            spaceforHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CategoryaddBloc, CategoryaddState>(
                  builder: (context, state) {
                    if (state is AddImageState) {
                      image = state.image;
                    }
                    return Container(
                      height: screenHeight / 3.5,
                      width: screenHeight / 2.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: state is! AddImageState
                                ? const NetworkImage(imageAddPageImage)
                                : FileImage(state.image) as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ],
            ),
            spaceforHeight10,
            PrimartButtonWithoutIcon(
                screenHeight: screenHeight,
                category: ButtonCategory.addCategoryImage),
            spaceforHeight10,
            Form(
              key: _formKey,
              child: Column(
                children: List.generate(
                  categoryAddPageTextEditingControllerHint.length,
                  (index) => CustomTextFormField(
                      controller: categoryAddPageTextEditingControllers[index],
                      hint: categoryAddPageTextEditingControllerHint[index],
                      obscureText: false),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        music = await Mp3PickerOperations.mp3Picker(context);
                        if (music != null) {
                          categoryAddPageTextEditingControllers.last.text =
                              music!.path.split('/').last;
                        }
                      },
                      child: const Text('Add Music'))
                ],
              ),
            ),
            const Text('Exercices'),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: CategoryAddPageExercises(listId: listId),
              ),
            ),
            spaceforHeight20,
            BlocListener<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryAddedSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(contant: 'new category added ') );
                    
                }
              },
              child: PrimartButtonWithoutIcon(
                screenHeight: screenHeight,
                category: ButtonCategory.saveCategory,
                formKey: _formKey,
                ontap: () {
                  if (_formKey.currentState!.validate() &&
                      music != null &&
                      image != null) {
                    categoryBloc.add(CategoryAddEvent(
                        image: image!,
                        music: music!,
                        controllers: categoryAddPageTextEditingControllers,
                        exerciseid: listId));
                  } else if (music == null) {
                    ScaffoldMessenger.of(context).showSnackBar( CustomSnackBar(contant: 'Please add a music file'));
                  }else if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar( CustomSnackBar(contant: 'Please add a image file'));
                  }
                },
              ),
            ),
            spaceforHeight20,
          ],
        ),
      )),
    );
  }
}

