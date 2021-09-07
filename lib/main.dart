import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/screens/home_page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String urlServer, bannarIsAd, interstIsAd, nativeIsAd;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final remoteConfig = await RemoteConfig.instance;
      final defaults = <String, dynamic>{
        'urlServer': 'kinglink2',
        'banarAdsisAndroid': '',
        'AdmobInterstitialisAndroidV2': 'ca-app-pub-9553130506719526/6017637180',
        'NativeAdmobisAndroid': '',
      };
    
      setState(() {
        urlServer = defaults['urlServer'];
        bannarIsAd = defaults['banarAdsisAndroid'];
        interstIsAd = defaults['AdmobInterstitialisAndroidV2'];
        nativeIsAd = defaults['NativeAdmobisAndroid'];
      });
    
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      setState(() {
        urlServer = remoteConfig.getString("urlServer");
        bannarIsAd = remoteConfig.getString("banarAdsisAndroid");
        interstIsAd = remoteConfig.getString("AdmobInterstitialisAndroidV2");
        nativeIsAd = remoteConfig.getString("NativeAdmobisAndroid");
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Whatsapp Group Links',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
      ),
      // Arabic RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),

      home: HomePage(urlServer: urlServer, bannarIsAd: bannarIsAd, interstIsAd: interstIsAd, nativeIsAd: nativeIsAd,),
    );
  }
}
