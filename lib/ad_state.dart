// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:io';

// class AdmobHelper {
//   static String get bannerUnit => "ca-app-pub-3940256099942544/6300978111";
//   static initialization() {
//     if (MobileAds.instance == null) {
//       MobileAds.instance.initialize();
//     }
//   }

//   static BannerAd getBannerAd() {
//     BannerAd bannerAd = new BannerAd(
//       size: AdSize.banner,
//       // هذا اعلان تجريبي
//       adUnitId: 'ca-app-pub-3940256099942544/6300978111',
//       // هذا اعلان حقيقي
//       // adUnitId: 'ca-app-pub-3940256099942544/6300978111',

//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('Ad Loaded');
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('Ad Failed');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) {
//           print('Ad Loaded');
//         },
//       ),
//       request: AdRequest(),
//     );

//     return bannerAd;
//   }
// }
