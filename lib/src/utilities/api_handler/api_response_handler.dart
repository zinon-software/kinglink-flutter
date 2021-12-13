import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/src/screens/home.dart';
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/api/shared_preferences_services.dart';

class APIResponseHandler {
  static void responseAuth(http.Response response, BuildContext context) {
    var jsonResponse;

    if (response.statusCode == HttpStatus.ok) {
      jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse["token"] != null) {
        SharedPrefs.saveToken(
            jsonResponse['token'].toString(), jsonResponse['id'].toString());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      } else {
        throw new Exception(jsonResponse);
      }
    } else if (response.statusCode == 400) {
      throw new Exception('تعذر تسجيل الدخول (تاكد بان بيانات الادخال صحيحة)');
    } else if (response.statusCode != 200 || response == null) {
      var jsonResponseError = convert.jsonDecode(response.body);
      throw new Exception(jsonResponseError['non_field_errors']);
    } else {
      throw new Exception('خطأ في تسجيل الدخول');
    }
  }
}
