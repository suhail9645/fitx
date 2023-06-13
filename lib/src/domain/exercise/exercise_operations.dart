import 'package:either_dart/either.dart';

import '../model/error/error.dart';
import '../model/exercise/exercise.dart';

abstract class ExerciseOperations{
  Future<Either<ErrorModel,bool>>addExercice(Exercise exercise,String groupValue);
}