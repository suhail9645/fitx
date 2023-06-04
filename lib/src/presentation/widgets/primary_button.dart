import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../config/constants/colors.dart';
import '../../config/enums/enums.dart';
import '../views/image_screen/bloc/image_bloc.dart';

class PrimartButtonWithoutIcon extends StatelessWidget {
  const PrimartButtonWithoutIcon({
    super.key,
    required this.screenHeight,
    required this.category
  });

  final double screenHeight;
  final ButtonCategory category;

  @override
  Widget build(BuildContext context) {
    int width=0;
    String text='';
    Color color=primaryColor;
    if(category==ButtonCategory.add){
      width=3;
      text='Add Image';
    }else if(category ==ButtonCategory.edit){
      width=6;
      text='Edit';
      color=Colors.blue;
    }else if(category==ButtonCategory.save){
      width=6;
      text='Save';
    }
    else if(category==ButtonCategory.addCategory){
      width=3;
      text='Add new';
    }
    return SizedBox(
      width: screenHeight / width,
      child: ElevatedButton(
        style:  ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color)),
        onPressed:() {
         if(category==ButtonCategory.add||category==ButtonCategory.edit){
          imageBloc.add(AddImageButtonClickedEvent());
         }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
