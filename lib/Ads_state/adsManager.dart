import 'dart:io';
// ignore: unused_import
import 'package:admob_flutter/admob_flutter.dart';

class AdsManager {
  static bool _testMode = true;

  ///
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526~4832613298";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9553130506719526~7068728548";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (_testMode == true) {
      // return '';
      return AdmobBanner.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/2231417956";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9553130506719526/3053655439";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (_testMode == true) {
      // return '';
      return AdmobInterstitial.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/5358298262";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9553130506719526/3516689861";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (_testMode == true) {
      return "ca-app-pub-3940256099942544/2247696110";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-9553130506719526/8914399890";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9553130506719526/7695414503";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}