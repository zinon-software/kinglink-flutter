import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



/*
 * This class used to hendler API Var And  ErrorMessage And Loading
 */
class APIHandler with ChangeNotifier {
  // URL API
  var basicUrl = "https://linkati.herokuapp.com";

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
