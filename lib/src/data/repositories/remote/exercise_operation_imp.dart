// ignore: implementation_imports
import 'dart:convert';
import 'package:either_dart/src/either.dart';
import 'package:fitx/src/config/constants/strings.dart';
import 'package:fitx/src/data/repositories/remote/get_new_access.dart';
import 'package:fitx/src/domain/model/exercise/exercise_page/exercise_page.dart';
import 'package:http/http.dart' as http;
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repo/exercise_operations.dart';

class ExerciseOperationsImp extends ExerciseOperations {
  @override
  Future<Either<ErrorModel, bool>> addExercice(
      Exercise exercise, String groupValue) async {
    try {
      final shred = await SharedPreferences.getInstance();
      String access = shred.getString('access')!;
      final response = await exerciseAddHelper(access, exercise, groupValue);
      if (response.statusCode == 201) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          final newResponse =
              await exerciseAddHelper(newAccess.right, exercise, groupValue);
          if (newResponse.statusCode == 201) {
            return const Right(true);
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session Expired'));
  }

  Future<StreamedResponse> exerciseAddHelper(
      String access, Exercise exercise, String groupValue) async {
    final shred = await SharedPreferences.getInstance();
    String access = shred.getString('access')!;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${baseUrl}exercise/create/"),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    var pic = await http.MultipartFile.fromPath(
      "demo",
      exercise.demo.path,
    );
    request.files.add(pic);

    request.fields.addAll({
      "name": exercise.name,
      "description": exercise.description,
      // "count": '10',
      groupValue.toLowerCase(): exercise.count != null
          ? exercise.count.toString()
          : exercise.duration.toString(),
      "burn_calorie": exercise.burnCalorie.toString(),
      "video_link": exercise.videoLink,
      "focused_area": exercise.focusedArea
    });
    StreamedResponse res = await request.send();
    return res;
  }

  @override
  Future<Either<ErrorModel, List<Exercise>>> getAllExercises() async {
    try {
      SharedPreferences shard = await SharedPreferences.getInstance();
      String access = shard.getString('access')!;
      Response response = await http.get(
          Uri.parse('${baseUrl}exercise/getall/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 200) {
        return Right(await exerciseFilterFromBody(response, access));
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.get(Uri.parse('${baseUrl}exercise/getall/'),
              headers: {'Authorization': 'Bearer $access'});
          return Right(await exerciseFilterFromBody(response, newAccess.right));
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  Future<List<Exercise>> exerciseFilterFromBody(
      Response response, String access) async {
    List<Exercise> exercises = [];
    while (true) {
      Map<String, dynamic> data = jsonDecode(response.body);
      ExercisePage exercisePage = ExercisePage.fromJson(data);

      for (var element in exercisePage.results ?? []) {
        Exercise exercise = Exercise.fromJson(element);
        exercises.add(exercise);
      }
      if (exercisePage.next != null) {
        response = await http.get(Uri.parse(exercisePage.next),
            headers: {'Authorization': 'Bearer $access'});
      } else {
        break;
      }
    }
    return exercises;
  }

  @override
  Future<Either<ErrorModel, bool>> deleteExercise(int id) async {
    try {
      SharedPreferences shard = await SharedPreferences.getInstance();
      String access = shard.getString('access')!;
      Response response = await http.delete(
          Uri.parse('${baseUrl}exercise/delete/$id/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 204) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newaccess = await GetNewAccessKey.getNewAccessKey();
        if (newaccess.isRight) {
          response = await http.delete(
              Uri.parse('${baseUrl}exercise/delete/$id/'),
              headers: {'Authorization': 'Bearer $access'});
          if (response.statusCode == 204) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  @override
  Future<Either<ErrorModel, bool>> updateExercise(
      Exercise exercise, String groupValue, int id) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      StreamedResponse response =
          await updateHelper(access, exercise, groupValue, id);
      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response =
              await updateHelper(newAccess.right, exercise, groupValue, id);
          if (response.statusCode == 200) {
            return const Right(true);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  Future<StreamedResponse> updateHelper(
      String access, Exercise exercise, String groupValue, int id) async {
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse("${baseUrl}exercise/update/$id/"),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    if (exercise.demo != null) {
      var pic = await http.MultipartFile.fromPath(
        "demo",
        exercise.demo.path,
      );
      request.files.add(pic);
    }
    request.fields.addAll({
      "name": exercise.name,
      "description": exercise.description,
      groupValue.toLowerCase(): exercise.count != null
          ? exercise.count.toString()
          : exercise.duration.toString(),
      "burn_calorie": exercise.burnCalorie.toString(),
      "video_link": exercise.videoLink,
      "focused_area": exercise.focusedArea
    });
    StreamedResponse response = await request.send();
    return response;
  }
}
