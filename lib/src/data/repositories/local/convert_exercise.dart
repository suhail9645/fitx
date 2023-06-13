import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ConvertExerciseObject {
 Future< Exercise> converting(
      List<TextEditingController> controllers, File gif, String timeOrCount)async {
    //       var pic = await http.MultipartFile.fromPath(
    //   "image",
    //   gif.path,
    // );

    return (Exercise(
        id: null,
        name: controllers[0].text,
        description: controllers[1].text,
        demo: gif,
        burnCalorie: int.parse(controllers[3].text),
        videoLink: controllers[2].text,
        focusedArea: controllers[4].text,
        count: timeOrCount == 'Count' ? int.parse(controllers[5].text) : null,
        duration: timeOrCount == 'Time' ? int.parse(controllers[5].text): null));
  }
}
