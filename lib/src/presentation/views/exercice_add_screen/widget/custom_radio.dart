import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../bloc/exercice_add_bloc.dart';

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
