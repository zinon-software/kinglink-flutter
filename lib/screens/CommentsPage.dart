import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/comments/comments_body.dart';

class CommentsPage extends StatelessWidget {
  final groupId;
  final groupName;
  const CommentsPage({Key key, this.groupId, this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: commentsAppBar(context),
      body: CommentsBody(
        groupId: groupId,
      ),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: AdsManager.bannerAdUnitId,
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
