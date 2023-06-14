import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../config/constants/strings.dart';

class GetNewAccessKey {
  static Future<Either<ErrorModel, String>> getNewAccessKey() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refresh = pref.getString('refresh')!;
      final response = await http.post(
          Uri.parse('${baseUrl}auth/token/refresh/'),
          body: jsonEncode({'refresh': refresh}),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        String newAccessKey = jsonDecode(response.body)['access'];
        pref.setString('access', newAccessKey);
        return Right(newAccessKey);
      }
      return Left(ErrorModel('session Expired'));
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
