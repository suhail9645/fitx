// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:fitx/src/config/constants/strings.dart';
import 'package:fitx/src/data/repositories/remote/access_key/get_new_access.dart';
import 'package:http/http.dart' as http;
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/exercise/exercise_operations.dart';

class ExerciseOperationsImp extends ExerciseOperations {
  @override
  Future<Either<ErrorModel, bool>> addExercice(Exercise exercise,String groupValue) async {
    try {
      final shred = await SharedPreferences.getInstance();
      String access = shred.getString('access')!;
      final response=await exerciseAddHelper(access, exercise,groupValue);
      if(response.statusCode==201){
        return const Right(true);
      }else if(response.statusCode==401){
        final newAccess=await GetNewAccessKey.getNewAccessKey();
        if(newAccess.isRight){
          final newResponse=await exerciseAddHelper(newAccess.right, exercise,groupValue);
          if(newResponse.statusCode==201){
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
      String access, Exercise exercise,String groupValue) async {
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
       groupValue.toLowerCase(): '10',
      "burn_calorie": exercise.burnCalorie.toString(),
      "video_link": exercise.videoLink,
      "focused_area": exercise.focusedArea
    });
    StreamedResponse res = await request.send();
    return res;
  }
}
