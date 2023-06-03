import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginFunctions{
  static Future< bool> adminLogin(String userName,String password)async{
   if(userName==dotenv.env['USERNAME']&&password==dotenv.env['PASSWORD']){
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('admin', true);
    await Future.delayed(Duration(seconds: 5));
    return true;
   }else{
    return false;
   }
  }
}