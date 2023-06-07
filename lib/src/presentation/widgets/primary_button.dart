import 'package:fitx/src/presentation/views/category_add_screen/bloc/categoryadd_bloc.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_page.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../config/constants/colors.dart';
import '../../config/enums/enums.dart';
import '../views/image_screen/bloc/image_bloc.dart';

class PrimartButtonWithoutIcon extends StatelessWidget {
  const PrimartButtonWithoutIcon(
      {super.key, required this.screenHeight, required this.category, this.formKey});

  final double screenHeight;
  final ButtonCategory category;
   final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    double width = 0;
    String text = '';
    Color color = primaryColor;
    if (category == ButtonCategory.add) {
      width = 3;
      text = 'Add Image';
    } else if (category == ButtonCategory.edit) {
      width = 6;
      text = 'Edit';
      color = Colors.blue;
    } else if (category == ButtonCategory.save) {
      width = 6;
      text = 'Save';
    } else if (category == ButtonCategory.addCategory) {
      width = 3;
      text = 'Add new';
    } else if (category == ButtonCategory.deletCategory) {
      width = 3.4;
      text = 'Delete Category';
      color = const Color(0xFFFE4A49);
    } else if (category == ButtonCategory.addCategoryImage) {
      width = 3;
      text = 'Add Image';
    } else if (category == ButtonCategory.saveCategory) {
      width = 3;
      text = 'Save Category';
    }
    return SizedBox(
      width: screenHeight / width,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
        onPressed: () {
          if (category == ButtonCategory.add ||
              category == ButtonCategory.edit) {
            imageBloc.add(AddImageButtonClickedEvent());
          } else if (category == ButtonCategory.addCategory) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>  CategoryAddPage(),
            ));
          } else if (category == ButtonCategory.addCategoryImage) {
            categoryaddBloc.add(AddImageEvent());
          }
          else if (category == ButtonCategory.saveCategory) {
          if(formKey!.currentState!.validate()){
                 
          }
          }
        },
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 36, 34, 34)),
        ),
      ),
    );
  }
}
