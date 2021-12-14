import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/src/api/group_services.dart';
import 'package:whatsapp_group_links/src/api/notification_services.dart';
import 'package:whatsapp_group_links/src/api/profile_services.dart';
import 'package:whatsapp_group_links/src/app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/api/auth_services.dart';
import 'src/utilities/widgets/theme_handler.dart';

SharedPreferences prefs;

void main() async {
  // runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  print(prefs.getString('user_id'));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthServices>(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => ProfileServices()),
        FutureProvider(create: (_) => GroupServices().getGroup()),
        FutureProvider(create: (_) => NotificationServices().getNotification()),
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

      home: Wrapper(),
    );
  }
}






// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String urlServer, bannarIsAd, interstIsAd, nativeIsAd;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final remoteConfig = await RemoteConfig.instance;
//       final defaults = <String, dynamic>{
//         'AdmobInterstitialisAndroidV2':
//             'ca-app-pub-9553130506719526/4874471126',
//         'urlServer': 'kinglink2',
//         'banarAdsisAndroid': '',
//         'NativeAdmobisAndroid': '',
//       };

//       setState(() {
//         interstIsAd = defaults['AdmobInterstitialisAndroidV2'];
//         urlServer = defaults['urlServer'];
//         bannarIsAd = defaults['banarAdsisAndroid'];
//         nativeIsAd = defaults['NativeAdmobisAndroid'];
//       });

//       await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//       await remoteConfig.activateFetched();
//       setState(() {
//         interstIsAd = remoteConfig.getString("AdmobInterstitialisAndroidV2");
//         urlServer = remoteConfig.getString("urlServer");
//         bannarIsAd = remoteConfig.getString("banarAdsisAndroid");
//         nativeIsAd = remoteConfig.getString("NativeAdmobisAndroid");
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Whatsapp Group Links',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
//         primaryColor: kPrimaryColor,
//         colorScheme:
//             ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
//       ),
//       // Arabic RTL
//       localizationsDelegates: [
//         GlobalCupertinoLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: [Locale("ar", "AE")],
//       locale: Locale("ar", "AE"),

//       home: HomePage(
//         urlServer: urlServer,
//         bannarIsAd: bannarIsAd,
//         interstIsAd: interstIsAd,
//         nativeIsAd: nativeIsAd,
//       ),
//     );
//   }
// }
