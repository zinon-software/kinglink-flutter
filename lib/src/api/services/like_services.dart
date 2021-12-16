import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class LikeServices {
  static Future<void> makeLike(String groupId) async {
    Map<String, String> headers = {
      "Authorization": "Token ${prefs.getString('token')}",
    };
    http.Response response = await http
        .post(Uri.parse(LIKE_URL), headers: headers, body: {'pk': groupId});

    if (response.statusCode == 200) {
      var jsonResponse;
      jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    }
  }
}
