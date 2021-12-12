import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/models/group_model.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/src/utilities/shared_preferences_handler.dart';

class GroupServices extends APIHandler {
  var jsonResponse;

  Future<List<GroupModel>> getGroup(BuildContext context) async {
    final sphProvider = Provider.of<SharedPreferencesHandler>(context);
    var token = await sphProvider.getToken();

    Map<String, String> headers = {
      "Authorization": "Token $token",
      "Content-Type": "application/json",
    };

    response = await http.get(
      Uri.parse("$basicUrl/api/group/"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(utf8.decode(response.bodyBytes));

      List<GroupModel> group = [];

      for (var item in body) {
        group.add(GroupModel.fromJson(item));
      }
      return group;
    }
    notifyListeners();
    return null;
  }

  Future<GroupModel> postGroup() async {}

  Future<GroupModel> putGroup() async {}

  Future<GroupModel> deleteGroup() async {}
}
