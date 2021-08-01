import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/screens/CommentsPage.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/color_dot.dart';

import 'package:http/http.dart' as http;


class DetailsBody extends StatefulWidget {
  final GroupsModel group;
  final urlServer;

  const DetailsBody({Key key, this.group, this.urlServer}) : super(key: key);

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  AdmobInterstitial interstitialAd;


  List dataCuontComments = []; //edited line

  Future<String> getCuontCommentsData() async {
    var res = await http
        .get(Uri.parse('https://${widget.urlServer}.herokuapp.com/api/Comment?group=${widget.group.id}'), headers: {"Accept": "application/json"});
    var resBody = jsonDecode(utf8.decode(res.bodyBytes));
    setState(() {
      dataCuontComments = resBody;
    });
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();

    getCuontCommentsData();

  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // to provide us the height and the width of the sceen
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorDot(
                        fillColor: kTextLightColor,
                        isSelected: true,
                      ),
                      ColorDot(
                        fillColor: Colors.blue,
                        isSelected: false,
                      ),
                      ColorDot(
                        fillColor: Colors.red,
                        isSelected: false,
                      ),
                    ],
                  ),
                ),
                AdsClass(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '   مجموعة:   ${widget.group.name}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          '   الناشر:   ${widget.group.createdBy}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                Center(
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () async {
                      var url = widget.group.link;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'تعذر الإطلاق  $url';
                      }
                    },
                    child: Text(
                      widget.group.category.name,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5,
                vertical: kDefaultPadding / 2,
              ),
              child: Text(
                ' الساعة :  ${widget.group.createdDt.hour}:${widget.group.createdDt.second}   ||  التاريخ :  ${widget.group.createdDt.day} / ${widget.group.createdDt.month} / ${widget.group.createdDt.year}',
                style: TextStyle(color: Colors.white, fontSize: 19.0),
              ),
            ),
          ),
          Center(
            child: Container(
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  if (interstitialAd != null) {
                    interstitialAd.show();
                  }
                  Get.to(
                    () => CommentsPage(
                      groupId: widget.group.id.toString(),
                      groupName: widget.group.name,
                      urlServer: widget.urlServer,
                    ),
                  );
                },
                child: Text('التعليقات  (${dataCuontComments.length})'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdsClass extends StatefulWidget {
  const AdsClass({Key key}) : super(key: key);

  @override
  _AdsClassState createState() => _AdsClassState();
}

class _AdsClassState extends State<AdsClass> {
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    super.initState();

    //Ads

    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    _nativeAdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20.0),
      child: NativeAdmob(
        adUnitID: AdsManager.nativeAdUnitId,
        numberAds: 3,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      ),
    );
  }
}
