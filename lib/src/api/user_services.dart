import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/models/group_model.dart';
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/utility/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utility/shared_preferences_handler.dart';

class ProfileServices extends APIHandler {
  var jsonResponse;

  Future<List<GroupModel>> getProfile(BuildContext context) async {
    final sphProvider = Provider.of<SharedPreferencesHandler>(context);
    var token = await sphProvider.getToken();

    Map<String, String> headers = {
      "Authorization": "Token $token",
      "Content-Type": "application/json",
    };

    response = await http.get(
      Uri.parse("$basicUrl/api/account/admin"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));

      List<GroupModel> group = [];

      for (var item in jsonResponse['group_list']) {
        group.add(GroupModel.fromJson(item));
      }
      return group;
    }
    notifyListeners();
    return null;
  }

  setMyGroup(BuildContext context) async {
    final sphProvider = Provider.of<SharedPreferencesHandler>(context);
    var token = await sphProvider.getToken();
    Map<String, String> headers = {
      "Authorization": "Token $token",
      "Content-Type": "application/json",
    };
    response = await http.post(
        Uri.parse("https://apitestings.herokuapp.com/todos/api/"),
        headers: headers,
        body: {
          'task': "Add 3",
          'completed': false,
        });

    if (response.statusCode == 201) {
      String responseString = response.body;
      // todosFromJson(responseString);
    } else {
      return null;
    }
  }
}
