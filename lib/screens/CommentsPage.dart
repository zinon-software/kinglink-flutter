import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/widgets/comments/comment_cart.dart';

class CommentsPage extends StatelessWidget {
  final groupId;
  final groupName;
  final urlServer;
  final bannarIsAd;
  const CommentsPage({Key key, this.groupId, this.groupName, this.urlServer, this.bannarIsAd}) : super(key: key);

  static bool _testMode = false;  // مفعل الاعلانات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commentsAppBar(context),
      body: TestMe(
        groupId: groupId,
        urlServer: urlServer,
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

  AppBar commentsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        groupName,
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
