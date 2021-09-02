import 'dart:convert';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/screens/CommentsPage.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/color_dot.dart';

import 'package:http/http.dart' as http;

import 'package:timeago/timeago.dart' as timeago;


class DetailsBody extends StatefulWidget {
  final GroupsModel group;
  final urlServer;
  final interstIsAd;
  final nativeIsAd;
  final bannarIsAd;

  const DetailsBody(
      {Key key, this.group, this.urlServer, this.nativeIsAd, this.interstIsAd, this.bannarIsAd})
      : super(key: key);

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  AdmobInterstitial interstitialAd;

  List dataCuontComments = []; //edited line

  Future<String> getCuontCommentsData() async {
    var res = await http.get(
        Uri.parse(
            'https://${widget.urlServer}.herokuapp.com/api/Comment?group=${widget.group.id}'),
        headers: {"Accept": "application/json"});
    var resBody = jsonDecode(utf8.decode(res.bodyBytes));
    setState(() {
      dataCuontComments = resBody;
    });
    return "Sucess";
  }

  // ignore: unused_field
  static bool _testMode = false; // مفعل الاعلانات

  //////
  /////////

  @override
  void initState() {
    super.initState();


    //Ads
    // interstitialAd = AdmobInterstitial(
    //   adUnitId: () {
    //     if (_testMode == true) {
    //       // return '';
    //       return AdmobInterstitial.testAdUnitId;
    //     } else if (Platform.isAndroid) {
    //       return widget.interstIsAd;
    //     } else if (Platform.isIOS) {
    //       return "ca-app-pub-9553130506719526/3516689861";
    //     } else {
    //       throw new UnsupportedError("Unsupported platform");
    //     }
    //   }(),
    //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     if (event == AdmobAdEvent.closed) interstitialAd.load();
    //   },
    // );

    // interstitialAd.load();

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
                AdsClass(nativeIsAd: widget.nativeIsAd),
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
                        Text( (){if (widget.group.createdBy == null ) {
                           return '   الناشر:  مجهول';
                        } else {
                          return '   الناشر:   ${widget.group.createdBy}';
                        }}(),
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
              child: Text(timeago.format(widget.group.createdDt),style: TextStyle(color: Colors.white, fontSize: 19.0),
              ),
            ),
          ),
          Center(
            child: Container(
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  // if (interstitialAd != null) {
                  //   if (widget.group.id % 2 == 0) {
                  //     interstitialAd.show();
                  //   }
                  // }
                  Get.to(
                    () => CommentsPage(
                      groupId: widget.group.id.toString(),
                      groupName: widget.group.name,
                      urlServer: widget.urlServer,
        bannarIsAd: widget.bannarIsAd,

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
  final nativeIsAd;
  const AdsClass({Key key, this.nativeIsAd}) : super(key: key);

  @override
  _AdsClassState createState() => _AdsClassState();
}

class _AdsClassState extends State<AdsClass> {
  final _nativeAdController = NativeAdmobController();
  static bool _testMode = false; // مفعل الاعلانات

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
        adUnitID: () {
          if (_testMode == true) {
            return "ca-app-pub-3940256099942544/2247696110";
          } else if (Platform.isAndroid) {
            return widget.nativeIsAd;
          } else if (Platform.isIOS) {
            return "ca-app-pub-9553130506719526/7695414503";
          } else {
            throw new UnsupportedError("Unsupported platform");
          }
        }(),
        numberAds: 3,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      ),
    );
  }
}
