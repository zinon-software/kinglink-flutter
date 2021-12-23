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

  Future<http.Response> putAdminGroup(String groupID) {
    return http.put(
      Uri.parse(ADMIN_URL),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'id': groupID,
      }),
    );
  }

  Future<GroupModel> deleteAdminGroup(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // will always return false on `FutureBuilder`.
      return GroupModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }

  Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
}
