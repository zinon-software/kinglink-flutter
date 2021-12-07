import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/src/auth/authentication.dart';

import 'package:whatsapp_group_links/src/utility/api_handler.dart';

class AuthServices extends APIHandler {
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
        Uri.parse("$basicUrl/api/account/register"),
        // Uri.parse("$basicUrl/api/account/register"),
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
        Uri.parse("https://apitestings.herokuapp.com/api/account/login"),
        // Uri.parse("$basicUrl/api/account/login"),
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
    // ignore: deprecated_member_use
    sharedPreferences.commit();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => Authentication(),
      ),
      (Route<dynamic> route) => false,
    );

    notifyListeners();
  }
}
