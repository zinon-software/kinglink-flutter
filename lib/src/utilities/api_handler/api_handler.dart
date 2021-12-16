import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_group_links/main.dart';

/*
 * This class used to hendler API Var And  ErrorMessage And Loading
 */
class APIHandler with ChangeNotifier {

  http.Response response;

  // Loading API >>>>>>>>>>>>>>>>>
  bool _isLoading = false;
  // Get the current Loading API
  bool get isLoading => _isLoading;
  // Change Loading API
  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  // Error Message API >>>>>>>>>>>>>>>>>>>>>>>
  String _errorMessage;
  // Get the current Error Message
  String get errorMessage => _errorMessage;
  // Change Error Message API
  void setErrorMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  var jsonResponse;

  Map<String, String> headers = {
    "Authorization": "Token ${prefs.getString('token')}",
    "Content-Type": "application/json",
  };
}
