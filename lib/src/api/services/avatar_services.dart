import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/api/models/avatar_model.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class AvatarServices extends APIHandler {
  Future<List<AvatarModel>> fetchAvatar() async {
    response = await http.get(Uri.parse(AVATAR_URL), headers: headers);

    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);

      List<AvatarModel> avatars = [];

      for (var item in jsonResponse) {
        avatars.add(AvatarModel.fromJson(item));
      }

      return avatars;
    }

    notifyListeners();
    return null;
  }
}
