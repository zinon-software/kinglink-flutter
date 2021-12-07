import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:whatsapp_group_links/src/home/home_screen.dart';
import 'package:whatsapp_group_links/src/utility/shared_preferences_handler.dart';

/*
 * This class used to hendler API Response Error
 */
class APIResponseErrorHandler {
  static String parseError(Exception ex) {
    if (ex is FormatException) {
      print(ex);
      return ex.message;
    } else if (ex is SocketException) {
      print(ex);
      return 'يرجى الاتصال بالإنترنت';
      // return 'No instance, please connect to internet : لا يوجد مثيل ، يرجى الاتصال بالإنترنت';
    } else {
      print(ex);
      return ex.toString().replaceAll(new RegExp(r'Exception:'), '');
    }
  }
}

/*
 * This class used to hendler API Var And  ErrorMessage And Loading
 */
class APIHandler with ChangeNotifier {
  // URL API
  var basicUrl = "https://apitestings.herokuapp.com";

  // Headers Login API
  Map<String, String> headersAuth = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  HttpClient client = HttpClient();

  http.Response response;

  // Loading API
  bool _isLoading = false;

  // Error Message API
  String _errorMessage;

  // Get the current Loading API
  bool get isLoading => _isLoading;

  // Get the current Error Message
  String get errorMessage => _errorMessage;

  // Change Loading API
  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  // Change Error Message API
  void setErrorMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}

class APIResponseHandler {
  static void responseAuth(http.Response response, BuildContext context) {
    var jsonResponse;

    if (response.statusCode == HttpStatus.ok) {
      jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse["token"] != null) {
        SharedPreferencesHandler.saveResponseAuth(
            jsonResponse['token'].toString());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
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
