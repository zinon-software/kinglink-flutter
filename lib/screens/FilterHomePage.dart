import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/filter_home_body.dart';

class FilterDataGroup extends StatelessWidget {
  final sectionsId;
  final sectionsName;
  final urlServer;
  final bannarIsAd;
  final interstIsAd;
  final nativeIsAd;

  const FilterDataGroup({Key key, this.sectionsId, this.sectionsName, this.urlServer,
      this.bannarIsAd,
      this.nativeIsAd,
      this.interstIsAd,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   bool _testMode = false;  // مفعل الاعلانات

    return Scaffold(
      appBar: detailsAppBar(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: kDefaultPadding / 3,
            ),
            FilterHomeBody(
              sectionsId: sectionsId,
              urlServer: urlServer,
              bannarIsAd: bannarIsAd,
              interstIsAd: interstIsAd,
              nativeIsAd: nativeIsAd,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: (){
            if (_testMode == true) {
              return AdmobBanner.testAdUnitId;
            } else if (Platform.isAndroid) {
              return bannarIsAd;
            } else if (Platform.isIOS) {
              return "ca-app-pub-9553130506719526/3053655439";
            } else {
              throw new UnsupportedError("Unsupported platform");
            }
          }(),
          adSize: AdmobBannerSize.SMART_BANNER(context),
        ),
      ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black45,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(right: kDefaultPadding),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        sectionsName,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
