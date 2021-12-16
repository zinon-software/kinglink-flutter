import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void>  saveToken(String token, String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);
    sharedPreferences.setString("user_id", userId);
  }
}
