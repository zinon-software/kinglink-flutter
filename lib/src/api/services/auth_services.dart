import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/screens/authentication.dart';

import 'package:whatsapp_group_links/src/utilities/api_handler/api_handler.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_response_error_handler.dart';
import 'package:whatsapp_group_links/src/utilities/api_handler/api_response_handler.dart';
import 'package:whatsapp_group_links/src/utilities/constants/urls.dart';

class AuthServices extends APIHandler {
  HttpClient client = HttpClient();

  // Headers Login API
  Map<String, String> headersAuth = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  Future<void> signUp(BuildContext context, String username, String email,
      String password) async {
    setLoading(true);

    try {
      Map<String, dynamic> bodyData = {
        "username": username,
        "email": email,
        "password": password,
        "password2": password,
      };

      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      IOClient ioClient = IOClient(client);

      response = await ioClient.post(
        Uri.parse(REGISTER_URL),
        headers: headersAuth,
        body: convert.jsonEncode(bodyData),
      );

      APIResponseHandler.responseAuth(response, context);
    } catch (ex) {
      setErrorMessage(APIResponseErrorHandler.parseError(ex));
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }

  Future<void> signIn(BuildContext context, String email, pass) async {
    setLoading(true);

    try {
      Map<String, dynamic> bodyData = {
        'username': email,
        'password': pass,
      };

      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      IOClient ioClient = IOClient(client);

      response = await ioClient.post(
        Uri.parse(LOGIN_URL),
        headers: headersAuth,
        body: convert.jsonEncode(bodyData),
      );

      APIResponseHandler.responseAuth(response, context);
    } catch (ex) {
      setErrorMessage(APIResponseErrorHandler.parseError(ex));
    } finally {
      setLoading(false);
    }
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    prefs.clear();
    // ignore: deprecated_member_use
    prefs.commit();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => Authentication(),
      ),
      (Route<dynamic> route) => false,
    );

    notifyListeners();
  }
}