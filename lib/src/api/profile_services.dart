import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class ProfileServices extends APIHandler {
  var jsonResponse;

  Map<String, String> headers = {
    "Authorization": "Token ${prefs.getString('token')}",
    "Content-Type": "application/json",
  };

  Future<List<GroupModel>> getProfileGroups(String id) async {
    response = await http.get(
      Uri.parse(PROFILE_URL + id + "/groups"),
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

  Future<UserModel> getUser(String id) async {
    response = await http.get(
      Uri.parse(PROFILE_URL + id),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));

      return UserModel.fromJson(jsonResponse);
    }
    notifyListeners();
    return null;
  }

  // setMyGroup(BuildContext context) async {
  //   final sphProvider = Provider.of<SharedPreferencesHandler>(context);
  //   var token = await sphProvider.getToken();
  //   Map<String, String> headers = {
  //     "Authorization": "Token $token",
  //     "Content-Type": "application/json",
  //   };
  //   response = await http.post(
  //       Uri.parse("https://apitestings.herokuapp.com/todos/api/"),
  //       headers: headers,
  //       body: {
  //         'task': "Add 3",
  //         'completed': false,
  //       });

  //   if (response.statusCode == 201) {
  //     String responseString = response.body;
  //     todosFromJson(responseString);
  //   } else {
  //     return null;
  //   }
  // }
}
