import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/src/api/services/admin_services.dart';
import 'package:whatsapp_group_links/src/api/services/avatar_services.dart';
import 'package:whatsapp_group_links/src/api/services/group_services.dart';
import 'package:whatsapp_group_links/src/api/services/notification_services.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/api/services/auth_services.dart';
import 'src/screens/authentication.dart';
import 'src/screens/home.dart';
import 'src/utilities/widgets/theme_handler.dart';

SharedPreferences prefs;
String urlServer, bannarIsAd, interstIsAd, nativeIsAd;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  print(prefs.getString('user_id'));

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{
      'AdmobInterstitialisAndroidV2': 'ca-app-pub-9553130506719526/4874471126',
      'urlServer': 'kinglink2',
      'banarAdsisAndroid': '',
      'NativeAdmobisAndroid': '',
    };

    interstIsAd = defaults['AdmobInterstitialisAndroidV2'];
    urlServer = defaults['urlServer'];
    bannarIsAd = defaults['banarAdsisAndroid'];
    nativeIsAd = defaults['NativeAdmobisAndroid'];

    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    interstIsAd = remoteConfig.getString("AdmobInterstitialisAndroidV2");
    urlServer = remoteConfig.getString("urlServer");
    bannarIsAd = remoteConfig.getString("banarAdsisAndroid");
    nativeIsAd = remoteConfig.getString("NativeAdmobisAndroid");
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServices>(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => ProfileServices()),
        ChangeNotifierProvider(create: (_) => GroupServices()),
        ChangeNotifierProvider(create: (_) => AdminServices()),
        ChangeNotifierProvider(create: (_) => NotificationServices()),
        FutureProvider(
            create: (_) => GroupServices().getGroup(), initialData: null),
        FutureProvider(
            create: (_) => AvatarServices().fetchAvatar(), initialData: null),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp Group Links',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      // Arabic RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),

      initialRoute: (prefs.getString('token') != null) ? '/home' : '/auth',

      routes: {
        '/home' : (context) => Home(),
        '/auth' : (context) => Authentication(),
      },

      // home: Wrapper(),
    );
  }
}