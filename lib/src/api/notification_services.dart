import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/notification_model.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class NotificationServices with ChangeNotifier {
  Map<String, String> headers = {
    "Authorization": "Token ${prefs.getString('token')}",
    "Content-Type": "application/json",
  };
  var jsonResponse;

  Future<List<NotificationModel>> getNotification() async {
    http.Response response =
        await http.get(Uri.parse(NOTIFICATIONS_URL), headers: headers);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      List<NotificationModel> notify = [];

      for (var item in body) {
        notify.add(NotificationModel.fromJson(item));
      }
      return notify;
    }
    notifyListeners();
    return null;
  }

  Future getShowNotification() async {
    http.Response response =
        await http.get(Uri.parse(SHOW_NOTIFICATIONS_URL), headers: headers);

    if (response.statusCode == 200) {
      print("done");
    }
    notifyListeners();
  }
}
