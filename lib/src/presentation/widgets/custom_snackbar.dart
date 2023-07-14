import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String contant;
  CustomSnackBar({super.key, required this.contant})
      : super(content: Text(contant));
}
