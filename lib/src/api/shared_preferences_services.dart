import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void>  saveToken(String token, String user_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);
    sharedPreferences.setString("user_id", user_id);
  }
}
