import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/Post_Page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/home_body.dart';

class HomePage extends StatefulWidget {
  final urlServer;
  final bannarIsAd;
  final interstIsAd;
  final nativeIsAd;
  const HomePage(
      {Key key,
      this.urlServer,
      this.bannarIsAd,
      this.interstIsAd,
      this.nativeIsAd})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobInterstitial interstitialAd;

  SectionsModel sectionsModel;
  FetchApi fetchApi = FetchApi();

  static bool _testMode = true; // مفعل الاعلانات

  @override
  void initState() {
    super.initState();

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: () {
        if (_testMode == true) {
          // return '';
          return AdmobInterstitial.testAdUnitId;
        } else if (Platform.isAndroid) {
          return widget.interstIsAd;
        } else if (Platform.isIOS) {
          return "ca-app-pub-9553130506719526/3516689861";
        } else {
          throw new UnsupportedError("Unsupported platform");
        }
      }(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      body: SafeArea(
        bottom: false,
        child: HomeBody(
          urlServer: widget.urlServer,
          bannarIsAd: widget.bannarIsAd,
          nativeIsAd: widget.nativeIsAd,
          interstIsAd: widget.interstIsAd,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Increment',
        // Within the `FirstRoute` widget
        onPressed: () {
          if (interstitialAd != null) {
            interstitialAd.show();
          }
          Get.to(
            () => PostPage(
              urlServer: widget.urlServer,
              bannarIsAd: widget.bannarIsAd,
              nativeIsAd: widget.nativeIsAd,
            ),
          );
        },
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        'مرحبا بكم في تطبيق قروباتي ',
        style: GoogleFonts.getFont('Almarai'),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //  Get.to(()=> AdExampleApp());
          },
        ),
      ],
    );
  }
}
