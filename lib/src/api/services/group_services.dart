import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/screens/home.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';

import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/src/utilities/api_handler/api_response_error_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class GroupServices extends APIHandler {
  Future<List<GroupModel>> getGroup() async {
    response = await http.get(
      Uri.parse(GROUPS_URL),
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

  Future<GroupModel> postGroup(
      BuildContext context, String titel, String link, String selection) async {
    setLoading(true);
    Map<String, String> headers = {
      "Authorization": "Token ${prefs.getString('token')}",
    };

    try {
      if (selection == null) throw new Exception('يجب تحديد القسم');
      print(selection.runtimeType);

      if (link.length < 12) throw new Exception('الرابط غير معرف لدينا');

      String category, linkSwitch = link.substring(0, 12);

      print(linkSwitch);
      switch (linkSwitch) {
        case "https://chat":
          category = 1.toString();
          break;
        case "https://t.me":
          category = 2.toString();
          break;
        case "https://yout":
          category = 3.toString();
          break;
        default:
          throw new Exception('الرابط غير معرف لدينا');
          break;
      }

      response = await http.post(
        Uri.parse(GROUPS_URL),
        headers: headers,
        body: {
          'titel': titel,
          'link': link,
          'category': category,
          'sections': selection,
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        setErrorMessage('تمت المشاركة');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      } else {
        throw new Exception(response.statusCode.toString());
      }
    } catch (ex) {
      final result = APIResponseErrorHandler.parseError(ex);
      setErrorMessage(result.toString());
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }
}
