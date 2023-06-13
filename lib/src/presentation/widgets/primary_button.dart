import 'dart:io';

import 'package:fitx/src/presentation/views/category_add_screen/bloc/categoryadd_bloc.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_page.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/bloc/exercice_add_bloc.dart';
import 'package:fitx/src/presentation/views/login_screen/login.dart';
import 'package:fitx/src/presentation/widgets/cutom_alert.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../config/constants/colors.dart';
import '../../config/enums/enums.dart';
import '../views/admin_profil/bloc/admin_bloc.dart';
import '../views/image_screen/bloc/add_image_bloc.dart';
import '../views/image_screen/bloc/image_bloc.dart';

class PrimartButtonWithoutIcon extends StatelessWidget {
  const PrimartButtonWithoutIcon(
      {super.key,
      required this.screenHeight,
      required this.category,
      this.formKey,
      this.image,
      this.id, this.groupValue});

  final double screenHeight;
  final ButtonCategory category;
  final GlobalKey<FormState>? formKey;
  final File? image;
  final int? id;
  final String? groupValue;
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
    } else if (category == ButtonCategory.logoutAdmin) {
      width = 3;
      text = 'Logout';
    } else if (category == ButtonCategory.cancelLogoutAdmin) {
      width = 8;
      text = 'No';
      color = const Color.fromARGB(255, 233, 94, 138);
    } else if (category == ButtonCategory.confirmLogoutAdmin) {
      width = 8;
      text = 'Yes';
      color = const Color.fromARGB(255, 233, 228, 94);
    } else if (category == ButtonCategory.addExerciceGif) {
      width = 3;
      text = 'Add Gif';
    } else if (category == ButtonCategory.saveExercice) {
      width = 3;
      text = 'Save Exercice';
    } else if (category == ButtonCategory.hireTrainer) {
      width = 3;
      text = 'Hire Trainer';
    } else if (category == ButtonCategory.deleteImage) {
      width = 6;
      text = 'Delete';
    }
    return SizedBox(
      width: screenHeight / width,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(color)),
        onPressed: () {
          if (category == ButtonCategory.add ||
              category == ButtonCategory.edit) {
            addImageBloc.add(AddImageButtonClickedEvent());
          } else if (category == ButtonCategory.addCategory) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryAddPage(),
            ));
          } else if (category == ButtonCategory.addCategoryImage) {
            categoryaddBloc.add(AddImageCategoryEvent());
          } else if (category == ButtonCategory.saveCategory) {
            if (formKey!.currentState!.validate()) {}
          } else if (category == ButtonCategory.logoutAdmin) {
            showDialog(
              context: context,
              builder: (context) =>
                  CustomAlertBoxWithoutImage(screenHeight: screenHeight),
            );
          } else if (category == ButtonCategory.confirmLogoutAdmin) {
            adminBloc.add(AdminLogoutEvent());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false);
          } else if (category == ButtonCategory.cancelLogoutAdmin) {
            Navigator.of(context).pop();
          } else if (category == ButtonCategory.addExerciceGif) {
            exerciceAddBloc.add(GifAddEvent(groupValue: groupValue??''));
          } else if (category == ButtonCategory.saveExercice) {
            if (formKey!.currentState!.validate()) {}
          } else if (category == ButtonCategory.save) {
            imageBloc.add(SaveImageButtonClickedEvent(image: image!));
          } else if (category == ButtonCategory.deleteImage) {
            imageBloc.add(ImageDeleteEvent(id: id!));
            Navigator.of(context).pop();
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
