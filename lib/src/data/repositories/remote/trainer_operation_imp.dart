import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx/src/data/repositories/remote/get_new_access.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/repo/trainer_operation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants/strings.dart';

class TrainerOperationImp extends TrainerOperation {
  @override
  Future<Either<ErrorModel, Response>> fetchAllTrainers() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      Response response = await http.get(
          Uri.parse('${baseUrl}trainer/applications/'),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 200) {
        return Right(response);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.get(
              Uri.parse('${baseUrl}trainer/applications/'),
              headers: {'Authorization': 'Bearer ${newAccess.right}'});
          if (response.statusCode == 200) {
            return Right(response);
          } else if (response.statusCode == 401) {
            return Left(ErrorModel('Session expired'));
          } else {
            String errorMessage = jsonDecode(response.body)['detail'];
            return Left(ErrorModel(errorMessage));
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session expired'));
  }

  @override
  Future<Either<ErrorModel, Response>> trainersFetchHelper(String endPoint) {
    // TODO: implement trainersFetchHelper
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, Response>> trainereAcceptAndReject(
      int id, String acceptOrReject) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('access')!;
      Response response = await http.post(
          Uri.parse('${baseUrl}trainer/respond/$id/'),
          body: {'response': acceptOrReject},
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 200) {
        return Right(response);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.post(
              Uri.parse('${baseUrl}trainer/respond/$id/'),
              body: {'response': acceptOrReject},
              headers: {'Authorization': 'Bearer${newAccess.right}'});
          if (response.statusCode == 200) {
            return Right(response);
          } else if (response.statusCode == 401) {
            return Left(ErrorModel('Session Expired'));
          } else {
            String? errorMessage = jsonDecode(response.body)['detail'];
            return Left(ErrorModel(errorMessage ?? 'Something wrong'));
          }
        }
      } else {
        String? errorMessage = jsonDecode(response.body)['detail'];
        return Left(ErrorModel(errorMessage ?? 'Something wrong'));
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Something wrong'));
  }
}
