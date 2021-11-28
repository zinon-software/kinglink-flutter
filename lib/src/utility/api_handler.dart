import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  var basicUrl = "https://kinglink2.herokuapp.com";

  // Headers Login API
  Map<String, String> headersAuth = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  var jsonResponse;
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

  Future<void> savePref(
      String token, String username, String email, String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);
    if (username != null) sharedPreferences.setString("username", username);
    if (email != null) sharedPreferences.setString("email", email);
    if (id != null) sharedPreferences.setString("id", id);
  }
}
