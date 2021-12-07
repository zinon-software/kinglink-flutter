import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/models/profile_model.dart';
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/utility/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utility/shared_preferences_handler.dart';

class ProfileServices extends APIHandler {
  var jsonResponse;
  Future<Object> getMyGroups(BuildContext context) async {
    try {
      final sphProvider = Provider.of<SharedPreferencesHandler>(context);
      var token = await sphProvider.getToken();
      Map<String, String> headers = {
        "Authorization": "Token $token",
        "Content-Type": "application/json",
      };

      response = await http.get(
          Uri.parse("https://apitestings.herokuapp.com/todos/api/"),
          headers: headers);

      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
        List<Todos> group = [];

        for (var item in jsonResponse) {
          group.add(Todos.fromJson(item));
        }
        return group;
      } else {
        throw new SocketException("no internet");
      }
    } on SocketException {
      print("no internet");
      return "no internet";
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Void> setMyGroup(BuildContext context) async {
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
      }
    );

    if (response.statusCode == 201) {
      String responseString = response.body;
      todosFromJson(responseString);
    } else {
      return null;
    }
  }
}
