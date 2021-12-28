import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class AdminServices extends APIHandler {
  Future<List<GroupModel>> fatchAdinGroups() async {
    response = await http.get(
      Uri.parse(ADMIN_URL),
      headers: headers,
    );

    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      List<GroupModel> group = [];

      for (var item in jsonResponse) {
        group.add(GroupModel.fromJson(item));
      }
      return group;
    }
    notifyListeners();
    return null;
  }

  Future<http.Response> putGroup({
    String groupID,
    String titel,
    String sections,
    String category,
    String link,
  }) {
    return http
        .put(
      Uri.parse(GROUPS_URL + groupID),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'titel': titel,
        'sections': sections,
        'category': category,
        'link': link,
      }),
    )
        .then((value) {
      print("تم التعديل");
      return null;
    });
  }

  String id; // group ID

  Future<GroupModel> deleteGroup({String groupID}) async {
    response = await http.delete(
      Uri.parse(GROUPS_URL + groupID),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      // will always return false on `FutureBuilder`.
      jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setErrorMessage(jsonResponse['res']);
      id = groupID;
      setLoading(true);
    } else if (response.statusCode == 400) {
      jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setErrorMessage(jsonResponse['res']);
      id = groupID;
      setLoading(true);
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      setErrorMessage('حدث خطا');
    }
    notifyListeners();
    return null;
  }

  Future<http.Response> shareAdminGroup(String groupID) {
    return http.put(
      Uri.parse(ADMIN_URL),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'id': groupID,
      }),
    );
  }
}
