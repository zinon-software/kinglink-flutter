
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/post/Post_Body.dart';


class PostPage extends StatelessWidget {
  const PostPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdmobBannerSize bannerSize;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: AdsManager.bannerAdUnitId,
          adSize: AdmobBannerSize.SMART_BANNER(context),
        ),
      ),
      body: PostBody(),
      // bottomNavigationBar: Container(
      //   child: AdWidget(
      //     ad: AdmobHelper.getBannerAd()..load(),
      //     key: UniqueKey(),
      //   ),
      //   height: 50,
      // ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(right: kDefaultPadding),
        icon: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}