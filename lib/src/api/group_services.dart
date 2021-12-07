import 'dart:io';

import 'package:whatsapp_group_links/src/utility/api_handler/api_handler.dart';

import 'package:http/http.dart' as http;

class GroupServices extends APIHandler {
  getGroup() async {
    Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };
    response = await http.get(Uri.parse("$basicUrl/api/group/"), headers: headers);
  }

  postGroup() async {}

  putGroup() async {}

  deleteGroup() async {}
}
