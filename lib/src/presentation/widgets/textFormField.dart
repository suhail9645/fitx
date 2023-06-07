import 'package:flutter/material.dart';

import '../../config/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscureText});

  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      child: TextFormField(  
        maxLines: hint=='Description'?3:1,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hint,
          floatingLabelStyle: const TextStyle(color: whiteColor),
          labelStyle: const TextStyle(color: whiteColor),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: lineColor),
          ),
        ),
        controller: controller,
        validator: (value) {
          if(value==null||value.isEmpty){
          return 'Please Enter the $hint';
          }
          return null;
        },
      ),
    );
  }
}