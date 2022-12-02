import 'package:shared_preferences/shared_preferences.dart';

class NewsCacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
  required String key,
  required bool value,
}) async{
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBoolean({
    required String key
  }){
    return sharedPreferences.getBool(key);
  }

  static Future<bool> putKey({
    required String key,
    required String value,
  }) async{
    return await sharedPreferences.setString(key, value);
  }

  static String? getKey({
    required String key
  }){
    return sharedPreferences.getString(key);
  }



}