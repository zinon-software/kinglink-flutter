import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_response_error_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class ProfileServices extends APIHandler {
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

  Future<List<UsersModel>> fatchUsers() async {
    response = await http.get(
      Uri.parse(USERS_URL),
      headers: headers,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(utf8.decode(response.bodyBytes));

      List<UsersModel> users = [];

      for (var item in body) {
        users.add(UsersModel.fromJson(item));
      }
      return users;
    }
    notifyListeners();
    return null;
  }

  Future<void> following(String userID) async {
    setLoading(true);
    try {
      response =
          await http.get(Uri.parse(FOLOWING_URL + userID), headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        setErrorMessage(jsonResponse.toString());
      }
    } catch (ex) {
      setErrorMessage(APIResponseErrorHandler.parseError(ex));
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }

  Future<void> putProfile(
      {BuildContext context,
      String name,
      String avatar,
      String description}) async {
        
    setLoading(true);

    Map<String, String> headers = {
      "Authorization": "Token ${prefs.getString('token')}",
    };

    response = await http.put(
      Uri.parse(PROFILE_URL + prefs.getString('user_id')),
      headers: headers,
      body: {
        'name': name,
        'avatar': avatar,
        'description': description,
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonResponse);
      print("تم التعديل");
      setLoading(false);
      Navigator.pop(context);
    }
    setLoading(false);
  }
}
