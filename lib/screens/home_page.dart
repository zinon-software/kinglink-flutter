import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/Post_Page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobInterstitial interstitialAd;

  SectionsModel sectionsModel;
  FetchApi fetchApi = FetchApi();

  String urlServer, bannarIsAd, interstIsAd, nativeIsAd;
  static bool _testMode = false;  // مفعل الاعلانات


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final remoteConfig = await RemoteConfig.instance;
      final defaults = <String, dynamic>{
        'urlServer': 'kinglink',
        'banarAdsisAndroid': '',
        'AdmobInterstitialisAndroid': '',
        'NativeAdmobisAndroid': '',
      };
    
      setState(() {
        urlServer = defaults['urlServer'];
        bannarIsAd = defaults['banarAdsisAndroid'];
        interstIsAd = defaults['AdmobInterstitialisAndroid'];
        nativeIsAd = defaults['NativeAdmobisAndroid'];
      });
    
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      setState(() {
        urlServer = remoteConfig.getString("urlServer");
        bannarIsAd = remoteConfig.getString("banarAdsisAndroid");
        interstIsAd = remoteConfig.getString("AdmobInterstitialisAndroid");
        nativeIsAd = remoteConfig.getString("NativeAdmobisAndroid");
      });
    });

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: (){
          if (_testMode == true) {
            // return '';
            return AdmobInterstitial.testAdUnitId;
          } else if (Platform.isAndroid) {
            return interstIsAd;
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
        child: HomeBody(urlServer:urlServer, bannarIsAd:bannarIsAd, nativeIsAd:nativeIsAd, interstIsAd: interstIsAd,),
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
            () => PostPage(urlServer:urlServer, bannarIsAd:bannarIsAd, nativeIsAd:nativeIsAd, ),
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
          onPressed: () {},
        ),
      ],
    );
  }

  
}
