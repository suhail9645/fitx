import 'package:either_dart/either.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:http/http.dart';

abstract class TrainerOperation {
  Future<Either<ErrorModel, Response>> fetchAllTrainers();
  Future<Either<ErrorModel, Response>> trainersFetchHelper(String endPoint);
  Future<Either<ErrorModel, Response>> trainereAcceptAndReject(
      int id, String acceptOrReject);
}
