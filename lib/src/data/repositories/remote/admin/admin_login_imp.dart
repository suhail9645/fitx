import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/auth/admin_login.dart';
import 'package:http/http.dart' as http;

class AdminLoginFunctionsImp extends AdminLoginFunctions {
  @override
  Future<bool> isAdmin(String userName, String password) async {
    Map<String, String> body = {
      'username': userName,
      'password': password,
    };
    try {
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/auth/token/'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(body));
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh', jsonDecode(response.body)['refresh']);
        await prefs.setString('access', jsonDecode(response.body)['access']);
        return true;
      }
    } on Exception catch (_) {
      return false;
    }
    return false;
  }
}
