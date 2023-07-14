import 'package:either_dart/either.dart';
import '../model/error/error.dart';
import '../model/exercise/exercise.dart';

abstract class ExerciseOperations {
  Future<Either<ErrorModel, bool>> addExercice(
      Exercise exercise, String groupValue);
  Future<Either<ErrorModel, List<Exercise>>> getAllExercises();
  Future<Either<ErrorModel, bool>> deleteExercise(int id);
  Future<Either<ErrorModel, bool>> updateExercise(
      Exercise exercise, String groupValue, int id);
}
