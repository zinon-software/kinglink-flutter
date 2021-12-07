
/*
 * This class used to hendler API Response Error
 */
import 'dart:io';

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