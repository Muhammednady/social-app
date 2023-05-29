import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setUserID(String userIDName,String userIDValue) async {
    return await sharedPreferences!.setString(userIDName, userIDValue);
  }

  static String?  getUserID(String userIDName) {
    return sharedPreferences!.getString(userIDName);
  }


  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value.toString());
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value as bool);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value.toInt());
    }

    return await sharedPreferences!.setString(key, value);
  }

  static Object? getData(String key) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> deleteToken(String token) async {
    return await sharedPreferences!.remove(token);
  }
}
